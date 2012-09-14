class Spree::SubscriptionsController < Spree::BaseController


  def create
    @errors = []

    if params[:email].blank?
      @errors << t('missing_email')
    elsif params[:email] !~ /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
      @errors << t('invalid_email_address')
    else
    is_member = false
    begin
      response = hominid.list_member_info(Spree::Config.get(:mailchimp_list_id), [params[:email]]).with_indifferent_access
      if response[:success] == true
        is_member = true
      end
    rescue Exception => e
      logger.warn "SpreeMailChimp: Failed to retrieve and store Mailchimp ID: #{e.message}"
    end

      if is_member
        @errors << t('that_address_is_already_subscribed')
      else
        begin
          hominid.list_subscribe(Spree::Config.get(:mailchimp_list_id), params[:email], {}, 'html', *mailchimp_subscription_opts)
        rescue Exception => e
          @errors << t('invalid_email_address')
        end
      end
    end
    puts @errors.inspect
    respond_to do |wants|
      wants.js
    end
  end

  private
  def hominid
    @hominid ||= Hominid::API.new(Spree::Config.get(:mailchimp_api_key))
  end

  def mailchimp_subscription_opts
    [Spree::Config.get(:mailchimp_double_opt_in), true, true, Spree::Config.get(:mailchimp_send_welcome)]
  end
end