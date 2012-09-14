require 'spec_helper'

COMPLICATED_INPUT = %(
Adam (adam@darowski.com) first introduced me to players like
the great @dahlebi01 who should not be confused with
@dahlgba01. I like turtles and @youngcy01!
)

COMPLICATED_OUTPUT = %(
Adam (adam@darowski.com) first introduced me to players like
the great <a href="/player/dahlebi01">Bill Dahlen</a> who should not be confused with
<a href="/player/dahlgba01">Babe Dahlgren</a>. I like turtles and <a href="/player/youngcy01">Cy Young</a>!
)

describe PlayerLinker do
  describe 'link_text' do
    before do
      create(:player, first_name: 'Cy', last_name: 'Young', id: 'youngcy01')
      create(:player, first_name: 'Bill', last_name: 'Dahlen', id: 'dahlebi01')
      create(:player, first_name: 'Babe', last_name: 'Dahlgren', id: 'dahlgba01')
    end

    it "transforms player ids into linked text" do
      input = "I once knew a man named @youngcy01 who could pitch a storm."
      expected = 'I once knew a man named <a href="/player/youngcy01">Cy Young</a> who could pitch a storm.'

      PlayerLinker.new(input).link_text.should == expected
    end

    it "does not molest emails" do
      input = "Email adam@darowski.com about @youngcy01."
      expected = 'Email adam@darowski.com about <a href="/player/youngcy01">Cy Young</a>.'

      PlayerLinker.new(input).link_text.should == expected
    end

    it "returns the original text if nothing can be linked" do
      input = "I remember when hot dogs cost a nickel."

      PlayerLinker.new(input).link_text.should == input
    end

    it "can handle a large number of matches" do
      PlayerLinker.new(COMPLICATED_INPUT).link_text.strip.should ==
        COMPLICATED_OUTPUT.strip
    end
  end
end
