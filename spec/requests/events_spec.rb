require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event, owner: user) }

  describe "イベント一覧" do
    subject  { get '/' }
 
    context "Event not exist" do
      it "Event count is 0" do
        subject
        expect(Event.count).to eq 0
      end
    end

    context "Event exist" do
      it "The number of events should be increased by one" do
        expect{ FactoryBot.create(:event, owner: user) }.to change { Event.count }.by(1)
      end
    end

    context "start_at, end_at" do
      let(:future_event) { FactoryBot.create(:event, start_at: Time.zone.now, end_at: Time.zone.now + 3.days, owner: user) }
      let(:past_event) { FactoryBot.create(:event, start_at: Time.zone.now, end_at: Time.zone.now + 1.days, owner: user) }
      subject { get '/' }

      before do
        sign_in_as(user)
        future_event
        past_event
      end

      it "display future event and don't display past event" do
        travel_to Time.zone.now + 2.days do
          subject
          puts response.body
          puts future_event.name
          #assert_selector "h5", text: future_event.name
          # expect(response.body).to have_content future_event.name
          #expect(page).to have_selector '.list-group-item-heading', future_event.name
          # within '.list-group-item-heading' do
          #   expect(page).to have_content future_event.name
          # end
        end
      end
    end
  end

  describe "Get event new" do
    context "/events/new" do
      it "display page name" do
        sign_in_as(user)

        visit new_event_url
        expect(page).to have_content 'New Event'
      end
    end
  end

  describe "Event create page" do
    describe "Event name" do
      # let(:event_name) { "a" * 50 }
      # let(:new_event) { FactoryBot.build(:event, owner: user, name: event_name) }
      # it "can create event event name length" do
      #   sign_in_as(user)
      #   post :create, params: { event: new_event }
      #   expect(response).to have_http_status(200)
    end
  end


  describe "Event show" do
    let(:event) { Event.create(
                   owner: user,
                   name: "Go to zoo",
                   place: "Fukuoka",
                   start_at: Time.current,
                   end_at: Time.current + 3600,
                   content: "see Animal!")
                }

    context "event content" do
      it "入力値を表示すること" do
        event
        visit event_url(event) # get events_url, params: { id: event.id }
        expect(page).to have_content event.name
        expect(page).to have_content event.place
        expect(page).to have_content event.content
      end
    end
  end

  describe "event update" do
    let(:param) {
      {
        event_name: "a" * 50
      }
    }

    before { sign_in_as(user) }
    subject { put "/events/#{event.id}", params: param }

    context "event name" do
      it "valid - event name" do
        event
        sign_in_as(user)
        visit event_url(event)
        subject
        puts response
        # expect(response[:event_name]).to eq 'a' * 50
        # expect(response.status).to eq 200
      end
    end
  end

  describe "event delete" do
    context "/events/:id display page and push delete button" do
      let(:user) { FactoryBot.create(:user) }
      let(:event) { FactoryBot.create(:event, owner: user) }

      subject { delete event_url(event) }
      before { event }
      it  do
        sign_in_as(user)
        visit event_url(event)
        expect(subject).to change { Event.count }.by(-1)
      end
    end
  end
end

#   describe "/events/new" do
#     sign_in_as(user)
#     it "show page" do
#     #   event = FactoryBot.create(:event)
#     #   event.owner_id = user.id
#       get new_event_url
#       # expect(response).to have_http_status(200) # なぜかログインできない
#     end
#   end
# end


# #   describe "/events/new  パージでフォームに入力して登録" do
# #     visit new_event_url
# #     event = FactoryBot.create(:event)

# #     assert_selector "h1", text: event.name
# #   end


# # describe ArticlesController do
# #     describe 'POST #create' do
# #        it "saves the new contact in the database" do
# #          expect{
# #            post :create, article: attributes_for(:article)
# #          }.to change(Article, :count).by(1)
# #        end
# #        it "redirects to articles#index" do
# #          post :create, article: attributes_for(:article)
# #          expect(response).to redirect_to articles_path
# #        end
# #      end
# # end
