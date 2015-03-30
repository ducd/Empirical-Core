require 'rails_helper'

describe Teachers::ProgressReports::Standards::ClassroomsController, type: :controller do
  render_views

  let!(:teacher) { FactoryGirl.create(:teacher) }
  it_behaves_like 'Progress Report'
end
