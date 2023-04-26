class EmployeesController < ApplicationController
  before_action :get_employee, only: [:edit, :update, :destroy]

  def index
    @employees = Employee.includes(:addresses).all
  end

  def new
    @employee = Employee.new
    @employee.addresses.build
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.hobby_id = params[:employee][:hobby_id].drop(1)
    if @employee.save
      redirect_to employees_path, notice: "you have successfully created an employee"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      @employee.update(hobby_id:  params[:employee][:hobby_id].drop(1))
      redirect_to employees_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @employee.destroy
      redirect_to employees_path, status: :see_other, notice: "you have successfully deleted the employee"
    else
      redirect_to employees_path, status: :unprocessable_entity, alert: "The delete action didn't work.."
    end
  end

  def search
    if params[:commit] == "Search"
      @employees = Employee.where(employee_name: params[:employee_name].strip)
    else
      @employees = Employee.all
    end
    render :index
  end

  private

  def get_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:employee_name, :email, :password, :birth_date, :gender, :mobile_number, :document, addresses_attributes: [:id, :house_name, :street_name, :road])
  end
end
