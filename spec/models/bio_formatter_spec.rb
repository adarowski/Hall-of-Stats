# coding: UTF-8
require 'spec_helper'

describe BioFormatter do
  describe 'mentioned_players' do
    subject(:mentioned_players) { BioFormatter.new(input).mentioned_players }

    context "when there are mentions of players" do
      let(:input) { "let's talk about @koufasa01 and @tenacge01" }
      before do
        Player.should_receive(:where).with(id: ['koufasa01', 'tenacge01']).
          and_return([:player_1, :player_2])
      end

      it { should == [:player_1, :player_2] }
    end

    context "when there are no mentions of players" do
      let(:input) { "hello there sally" }

      it { should == [] }
    end
  end

  describe 'linked_text' do
    context "when there is nothing to link" do
      it "returns the original text if nothing can be linked" do
        input = "I remember when hot dogs cost a nickel."

        BioFormatter.new(input).linked_text.should == input
      end
    end

    context "when there is a player to link" do
      before do
        Player.should_receive(:where).with(id: ['youngcy01']).and_return [
           build(:player, id: 'youngcy01', first_name: 'Cy', last_name: 'Young',
                 war_tot: BigDecimal.new(1.33, 3), img_url: '/images/players/youngcy01.jpg')
        ]
      end

      it "transforms player ids into linked text" do
        input = "I once knew a man named @youngcy01 who could pitch a storm."
        expected = %(I once knew a man named [Cy Young](/player/youngcy01 "View Cy Young's page") who could pitch a storm.)

        BioFormatter.new(input).linked_text.should == expected
      end

      it "works for strings that begin with a player id" do
        input = "@youngcy01 drives a Dodge Stratus!"
        expected = %([Cy Young](/player/youngcy01 "View Cy Young's page") drives a Dodge Stratus!)

        BioFormatter.new(input).linked_text.should == expected
      end

      it "works for strings that have player ids butted up against other text" do
        input = "don't shoot me —@youngcy01 is my homey!"
        expected = %(don't shoot me —[Cy Young](/player/youngcy01 "View Cy Young's page") is my homey!)

        BioFormatter.new(input).linked_text.should == expected
      end

      it "does not molest emails" do
        input = "Email adam@darowski.com about @youngcy01."
        expected = %(Email adam@darowski.com about [Cy Young](/player/youngcy01 "View Cy Young's page").)

        BioFormatter.new(input).linked_text.should == expected
      end

      it "should be able to insert data requested for a player via the @id:data format" do
        input = "As opposed to @youngcy01, whose war_tot was @youngcy01:war_tot. Here's a picture of him: @youngcy01:img_url"
        expected = %(As opposed to [Cy Young](/player/youngcy01 "View Cy Young's page"), whose war_tot was 1.33. Here's a picture of him: /images/players/youngcy01.jpg)
        BioFormatter.new(input).linked_text.should == expected
      end
    end

    context "with complicated input and multiple players" do
      before { mock_many_players }

      it "links all players" do
        input = File.read("#{Rails.root}/spec/support/fixtures/bio.markdown")
        expected = File.read("#{Rails.root}/spec/support/fixtures/bio.processed.markdown")

        BioFormatter.new(input).linked_text.strip.should == expected.strip
      end
    end

    context "with... context :/" do
      before { mock_many_players }

      it "uses the context player's name and links other players" do
        input = File.read("#{Rails.root}/spec/support/fixtures/bio.markdown")
        expected = File.read("#{Rails.root}/spec/support/fixtures/bio.processed.context.markdown")

        BioFormatter.new(input, 'koufasa01').linked_text.strip.should == expected.strip
      end
    end
  end

  describe '#to_s' do
    context "with multiple paragraphs" do
      let(:linker) { BioFormatter.new("\n\nSome content.\n\nMore content.\n\nFinal line.") }

      it "is the marked-down version of everything" do
        linker.to_s.should == "<p>Some content.</p>\n\n<p>More content.</p>\n\n<p>Final line.</p>\n"
      end
    end
  end

  private

  def mock_many_players
    expected_ids = [
      'koufasa01',
      'freehbi01',
      'simmote01',
      'tenacge01',
      'fiskca01',
      'benchjo01',
      'cartega01'
    ]

    Player.should_receive(:where).with(id: expected_ids).and_return [
      build(:player, id: 'koufasa01', first_name: 'Sandy', last_name: 'Koufax'),
      build(:player, id: 'freehbi01', first_name: 'Bill', last_name: 'Freehan'),
      build(:player, id: 'simmote01', first_name: 'Ted', last_name: 'Simmons'),
      build(:player, id: 'tenacge01', first_name: 'Gene', last_name: 'Tenace'),
      build(:player, id: 'fiskca01', first_name: 'Carlton', last_name: 'Fisk'),
      build(:player, id: 'benchjo01', first_name: 'Johnny', last_name: 'Bench'),
      build(:player, id: 'cartega01', first_name: 'Gary', last_name: 'Carter')
    ]
  end
end
