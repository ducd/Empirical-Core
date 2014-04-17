class Teachers::ClassroomManagerController < ApplicationController
  layout 'classroom_manager'
  before_filter :teacher!
  before_filter :authorize!

  def scorebook
    @unit = @classroom.units.find_by_id(params[:unit_id]) || @classroom.units.first
    @topic = @unit.topics.find_by_id(params[:topic_id])  || @unit.topics.first

    @classroom_activities = if @topic.blank?
      []
    else
      @unit.classroom_activities.joins(:topic).where(topics: {id: @topic.id})
    end

    if @unit.topics.any?
      @score_table = {}

      @classroom.students.each do |student|
        @score_table[student.name] = {}

        @classroom_activities.each do |classroom_activity|
          @score_table[student.name][classroom_activity.activity] = if classroom_activity.for_student?(student)
            activity_session = student.activity_sessions.rel_for_activity(classroom_activity.activity).includes(:classroom_activity).where(classroom_activity_id: classroom_activity.id).current_session
            { session: activity_session }
          else
            nil
          end
        end
      end
    end
  end

  def lesson_planner
    @workbook_table = {}

    (Activity.production - @classroom.activities.production).each do |activity|
      @workbook_table[activity.topic.section.position] ||= {}
      @workbook_table[activity.topic.section.position][activity.topic.section.name] ||= {}
      @workbook_table[activity.topic.section.position][activity.topic.section.name][activity.topic.name] ||= []
      @workbook_table[activity.topic.section.position][activity.topic.section.name][activity.topic.name] << activity
    end

    @workbook_table = @workbook_table.map.to_a.sort{|a,b| a.first <=> b.first}.map(&:last).map(&:to_a).map(&:first)
  end

protected

  # TODO: this is copied from Teachers::ClassroomsController#authorize!
  #       consider absracting using inheritance e.g. Teachers::BaseClassroomController
  def authorize!
    @classroom = Classroom.find(params[:classroom_id])
    auth_failed unless @classroom.teacher == current_user
  end
end
