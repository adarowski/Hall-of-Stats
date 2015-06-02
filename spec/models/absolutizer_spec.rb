require 'spec_helper'

describe Absolutizer do
  HTML = %(
    <p>
      <img src="/assets/thumbs/munsoth01.jpg" />
      <a href="/player/munsoth01">Thurman Munson</a> played until 1979.
    </p>

    <p>
      <img src="http://google.com/wait-what/haha.jpg" />
      <img src="https://ask.com/people-use-this/really.gif" />
      <a href="http://yahoo.com/player/freehbi01">this link</a> is irrelevant.
    </p>
  )

  RENDERED = %(
    <p>
      <img src=\"http://test.com/assets/thumbs/munsoth01.jpg\">
      <a href=\"http://test.com/player/munsoth01\">Thurman Munson</a> played until 1979.
    </p>

    <p>
      <img src=\"http://google.com/wait-what/haha.jpg\">
      <img src=\"https://ask.com/people-use-this/really.gif\">
      <a href=\"http://yahoo.com/player/freehbi01\">this link</a> is irrelevant.
    </p>
  )

  describe 'absolutize_html' do
    subject(:absolutize_html) { Absolutizer.absolutize_html(HTML, 'http://test.com') }

    context "for IMG tags" do
      it { should include("http://test.com/assets/thumbs/munsoth01.jpg") }
      it { should include("http://google.com/wait-what/haha.jpg") }
      it { should include("https://ask.com/people-use-this/really.gif") }
    end

    context "for A tags" do
      it { should include("http://test.com/player/munsoth01") }
      it { should include("http://yahoo.com/player/freehbi01") }
    end

    it { should == RENDERED }
  end
end
