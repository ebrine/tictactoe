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
      it "returns status 400 for boards that are won horizontally" do
        get '/?board=ooo+x+x+x'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 for boards that are won vertically" do
        get '/?board=xooxo+x++'
        expect(last_response.status).to eq 400
      end
      it "returns status 400 when it's x's turn" do
        get '/?board=oo+xx+oox'
        expect(last_response.status).to eq 400
      end
    end

    describe "valid boards" do
      it "returns status 200 when it's plausibly o's turn on valid board" do
        get '/?board=o++xx+oox'
        expect(last_response.status).to eq 200
      end
      it "returns status 200 when it's plausibly o's turn on valid board" do
        get '/?board=o++xx+o+x'
        expect(last_response.status).to eq 200
      end
    end

    describe "valid responses" do
      it "returns board with corner move if empty board is given" do
        get '/?board=+++++++++'
        expect(last_response.body).to eq 'o        '
      end
      describe "blocking x's winning moves" do
        it "returns board with x horizontal winning move blocked" do
          get '/?board=o++xx+o+x'
          expect(last_response.body).to eq 'o  xxoo x'
        end
        it "returns board with x vertical winning move blocked" do
          get '/?board=oxo+x+++x'
          expect(last_response.body).to eq 'oxo x  ox'
        end
        it "returns board with x diagonal winning move blocked" do
          get '/?board=++ooxox+x'
          expect(last_response.body).to eq 'o ooxox x'
        end
      end
      describe "completes o's winning moves" do
        it "returns board with o vertical winning move complete" do
          get '/?board=o+++x+o+x'
          expect(last_response.body).to eq 'o  ox o x'
        end
        it "returns board with o diagonal winning move complete" do
          get '/?board=ox+x++x+o'
          expect(last_response.body).to eq 'ox xo x o'
        end
        it "returns board with o horizontal winning move complete" do
          get '/?board=oo+x++x+x'
          expect(last_response.body).to eq 'ooox  x x'
        end
        it "returns board with additional o" do
          get '/?board=x+xooxoxo'
          expect(last_response.body).to eq 'xoxooxoxo'
        end
      end
      describe "when no winning move or blockable move" do
        it "returns board with additional o on corner if possible" do
          get '/?board=++++o+x++'
          expect(last_response.body).to eq 'o   o x  '
        end
        it "returns board with additional o anywhere if corner not possible" do
          get '/?board=x+oooxxxo'
          expect(last_response.body).to eq 'xooooxxxo'
        end
        it "returns board with additional o anywhere if corner not possible" do
          get '/?board=x+oo+xx+o'
          expect(last_response.body).to eq "xooo xx o"
        end
      end
    end

  end


end
