class CreateSchema < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :encrypted_passwd, null: false
      t.integer :gender
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :status, default: 0, null: false
      t.integer :role
    end

    create_table :articles, id: :uuid do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :slug
      t.string :description
      t.uuid :author_id, null: false
      t.text :content, null: false
      t.string :comments_count, null: false, default: "0"
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :status, default: 0, null: false
    end

    add_index :articles, :slug, unique: true

    add_foreign_key :articles, :users, column: :author_id, primary_key: :id

    create_table :comments, id: :uuid do |t|
      t.string :title, null: false
      t.string :content
      t.uuid :author_id, null: false
      t.uuid :article_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :status, default: 0, null: false
    end

    add_foreign_key :comments, :users, column: :author_id, primary_key: :id

    create_table :identities, id: :uuid do |t|
      t.string :uid
      t.string :provider
      t.uuid :user_id
    end

    add_index :identities, :user_id

    create_table :messages, id: :uuid do |t|
      t.uuid :user_id
      t.string :user_name
      t.string :user_avatar
      t.text :content
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    add_index :messages, :user_id

    create_table :active_admin_comments do |t|
      t.string :namespace
      t.text   :body
      t.string :resource_id,   null: false
      t.string :resource_type, null: false
      t.references :author, polymorphic: true
      t.timestamps
    end
    add_index :active_admin_comments, [:namespace]
    add_index :active_admin_comments, [:author_type, :author_id]
    add_index :active_admin_comments, [:resource_type, :resource_id]

    create_table :news, id: :uuid do |t|
      t.string :title
      t.string :url
      t.integer :provider
      t.uuid :news_sourceurl_id
      t.timestamps
    end

    add_index :news, :news_sourceurl_id

    create_table :news_sourceurls, id: :uuid do |t|
      t.string :description
      t.string :source_url
      t.timestamps
    end
  end

end
