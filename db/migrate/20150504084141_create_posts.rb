class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to(:user, :index => true)

      t.integer(:trade_type)
      t.string(:title)
      t.string(:author)
      t.string(:course)
      t.string(:edition)
      t.integer(:price)
      t.text(:book_condition)
      t.text(:contact)

      t.timestamps null: false
    end
  end
end
