require_relative "spec_helper"

describe "app controller" do
  describe "GET /" do

    describe "invalid boards" do
      it "returns status 400 for boards that are not a 9 char string" do
        get '/?board=xoxox'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards that contain characters other than x, o and space" do
        get '/?board=xox+*-1@#'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards that contain characters other than x, o and space" do
        get '/?board=xox+aaabb'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards where difference between number of x's and o's is more than 1" do
        get '/?board=xxxxo+++o'
        expect(last_response.status).to eq 400
      end
    end

    describe "not o's turn" do
      it "returns status 400 for boards that are complete" do
        get '/?board=xoxoxoxox'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards that are won diagonally" do
        get '/?board=xoo+x+o+x'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards that are won horizontally" do
        get '/?board=xxx+o+o+o'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards that are won vertially" do
        get '/?board=xooxo+x++'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 when it's x's turn" do
        get '/?board=oo+xx+oox'
        expect(last_response.status).to eq 400
      end
    end

    describe "valid boards" do

    end

  end


end
