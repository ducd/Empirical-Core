class StudentsClassroomsController < ApplicationController

    def create
      @user = current_user
      classcode = params[:classcode]
      begin
        classroom = Classroom.where(code: classcode).first
        Associators::StudentsToClassrooms.run(@user, classroom)
        JoinClassroomWorker.perform_async(@user.id)
      rescue NoMethodError => exception
        render json: {
                      error: "No such clascode",
                      status: 400
                    }, status: 400
      else
        render json: classroom.attributes
      end

    end

    def hide
      row = StudentsClassrooms.where(student_id: params[:student_id], classroom_id: params[:classroom_id]).first
      row.update(visible: false)
      redirect_to teachers_classrooms_path
    end

    def add_classroom
      render :add_classroom
    end


end
