require 'spec_helper'

describe BioFormatter do
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
           build(:player, id: 'youngcy01', first_name: 'Cy', last_name: 'Young')
        ]
      end

      it "transforms player ids into linked text" do
        input = "I once knew a man named @youngcy01 who could pitch a storm."
        expected = %(I once knew a man named [Cy Young](/player/youngcy01 "View Cy Young's page") who could pitch a storm.)

        BioFormatter.new(input).linked_text.should == expected
      end

      it "does not molest emails" do
        input = "Email adam@darowski.com about @youngcy01."
        expected = %(Email adam@darowski.com about [Cy Young](/player/youngcy01 "View Cy Young's page").)

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
  end

  describe '#lead_in' do
    context "with only one paragraph" do
      let(:linker) { BioFormatter.new("\n\nSome content.\n\n") }

      it "is the marked-down version of the first paragraph" do
        linker.lead_in.should == "<p>Some content.</p>\n"
      end
    end

    context "with multiple paragraphs" do
      let(:linker) { BioFormatter.new("\n\nSome content.\n\nMore content.\n\nFinal line.") }

      it "is the marked-down version of the first paragraph and a read more link" do
        linker.lead_in.should == %(<p>Some content. <a href="#" id="show-bio">Read more&hellip;</a></p>\n)
      end
    end
  end

  describe '#body' do
    context "with only one paragraph" do
      let(:linker) { BioFormatter.new("\n\nSome content.\n\n") }

      it "is nil" do
        linker.body.should be_nil
      end
    end

    context "with multiple paragraphs" do
      let(:linker) { BioFormatter.new("\n\nSome content.\n\nMore content.\n\nFinal line.") }

      it "is the marked-down version of everything after the first paragraph" do
        linker.body.should == "<p>More content.</p>\n\n<p>Final line.</p>\n"
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
