class AdvertisementPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.admin_token == user
  end

  def destroy?
    record.admin_token == user
  end

  def permitted_attributes_for_create
    %i[
      author_name author_email author_phone terms_of_service
    ] + common_attributes_for_advertisement
  end

  def permitted_attributes_for_update
    common_attributes_for_advertisement
  end

  def common_attributes_for_advertisement
    %i[
      ad_type title location description price
    ]
  end
end
