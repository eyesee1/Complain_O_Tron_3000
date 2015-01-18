module NoAssetIdInDev
  def self.included(base)
    base.send(:include, SingletonMethods)
    base.class_eval do
      alias_method_chain :rails_asset_id, :no_asset_id_in_dev
    end
  end
  
  module SingletonMethods
    def rails_asset_id_with_no_asset_id_in_dev(source)
      cssedit_ua_string_re = /Safari$/
      return "" if cssedit_ua_string_re =~ request.env['HTTP_USER_AGENT'] && RAILS_ENV == 'development'
      ENV["RAILS_ASSET_ID"] ||
        File.mtime(File.join(ActionView::Helpers::AssetTagHelper::ASSETS_DIR, source)).to_i.to_s rescue ""
    end
  end
end

ActionView::Helpers::AssetTagHelper.send(:include, NoAssetIdInDev)