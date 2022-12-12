class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      # 退会機能をつくるため、ユーザーはNULLを許可
      t.references :user
      # ユーザーが重複してイベントを登録できることがないように複合インデックスを追加
      # references メソッドでデフォルトで作られるevent_id 単体インデックスは不要
      t.references :event, null: false, foreign_key: true, index: false
      t.string :comment

      t.timestamps
    end

    add_index :tickets, %i[event_id user_id], unique: true
  end
end
