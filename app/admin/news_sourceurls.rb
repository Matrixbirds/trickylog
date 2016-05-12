ActiveAdmin.register NewsSourceurl do
  menu :priority => 3, label: proc{ I18n.t "news_sourceurl" }
  permit_params :source_url, :description
  index do
    column "源地址", :source_url
    column "描述", :description
    actions default: true do |resource|
      link_to('导入', admin_import_news_sourceurl_path(resource), method: :post)
    end
  end

  controller do
    def import_news
      @source_url = NewsSourceurl.find(params[:id])
      NewsImportWorker.perform_async(@source_url.source_url)
      flash[:success] = "成功"
      redirect_to :back
    end
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
