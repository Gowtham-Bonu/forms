class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :employee_name
      t.string :email
      t.string :password
      t.string :gender
      t.string :hobby_id, array:true, default: []
      t.string :address
      t.string :mobile_number
      t.date :birth_date
      t.text :document

      t.timestamps
    end
  end
end
