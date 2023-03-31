class EmployeesController < ApplicationController
  before_action :get_employee, only: [:edit, :update, :destroy]

  def new
    @employee = Employee.new
    @employee.addresses.build
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      @employee.update(hobbies: [["music", params[:hobbies][:music]], ["writing", params[:hobbies][:writing]], ["singing", params[:hobbies][:singing]]])
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @employees = Employee.includes(:addresses).all
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      @employee.update(hobbies: [["music", params[:hobbies][:music]], ["writing", params[:hobbies][:writing]], ["singing", params[:hobbies][:singing]]])
      redirect_to employees_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path
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
    params.require(:employee).permit(:employee_name, :email, :password, :birth_date, :gender, :hobbies, :mobile_number, :document, addresses_attributes: [:id, :house_name, :street_name, :road])
  end
end