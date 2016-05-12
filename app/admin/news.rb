ActiveAdmin.register News do
  menu :priority => 4, label: proc{ I18n.t "news" }
  permit_params :title, :url, :provider, :description

  index do
    column "标题", :title
    column "提供者", :provider
    column "描述", :description
  end

end
