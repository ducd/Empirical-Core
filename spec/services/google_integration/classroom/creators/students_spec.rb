require 'rails_helper'

describe 'GoogleIntegration::Classroom::Creators::Students' do

  def subject(classrooms, students_requester)
    x = GoogleIntegration::Classroom::Creators::Students.run(classrooms, students_requester)
    x.map(&:reload).map{ |y| { name: y.name, email: y.email } }
  end

  let!(:classroom) { FactoryGirl.create(:classroom) }
  let!(:classrooms) { [classroom] }

  let!(:students_requester) {
    lambda do |course_id|
      x = {
            "students":
            [
              {"courseId":"455798942",
               "userId":"107708392406225674265",
               "profile":
                  {"id":"107708392406225674265",
                   "name":
                    {"givenName":"test1_s1",
                     "familyName":"s1",
                     "fullName":"test1_s1 s1"},
                    "emailAddress":"test1_s1@gedu.demo.rockerz.xyz"
                  }
              },
              {"courseId":"2",
               "userId":"2",
               "profile":
                  {"id":"2",
                   "name":
                    {"givenName":"test1_s2",
                     "familyName":"s2",
                     "fullName":"test1_s2 s2"},
                    "emailAddress":"test1_s2@gedu.demo.rockerz.xyz"
                  }
              }
            ]
      }
      body = x.to_json
      Response = Struct.new(:body)
      response = Response.new(body)
      return response
    end
  }

  context 'no students have been previously created' do
    let!(:expected) {
      [
        { name: 'Test1_s1 S1', email: 'test1_s1@gedu.demo.rockerz.xyz'},
        { name: 'Test1_s2 S2', email: 'test1_s2@gedu.demo.rockerz.xyz'}
      ]
    }

    it 'creates all the students' do
      expect(subject(classrooms, students_requester)).to eq(expected)
    end
  end


  context 'activities have been assigned to the classroom in the past' do

    def subject
      GoogleIntegration::Classroom::Creators::Students.run(classrooms, students_requester)
    end

    let!(:activity) { FactoryGirl.create(:activity) }
    let!(:classroom_activity) { FactoryGirl.create(:classroom_activity, classroom: classroom, activity: activity) }

    it 'assigns those activities to the new students' do
      students = subject
      acss = ActivitySession.where(classroom_activity: classroom_activity, user: students.map(&:id))
      expect(acss.count).to eq(students.count)
    end
  end
end