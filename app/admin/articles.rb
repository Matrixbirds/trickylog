ActiveAdmin.register Article do
  menu :priority => 2, label: proc{ I18n.t "article" }
  permit_params :title, :subtitle, :content, :created_at, :updated_at
  index do
    column "标题", :title
    column "描述", :description
    column "作者", :author
    column "创建时间", :created_at
    column "更新时间", :updated_at
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
