module AdvertisementRepresentations
  include AsJsonRepresentations

  representation :basic do |options|
    %i[
      id ad_type title location description price author_name author_email author_phone
      created_at updated_at
    ].each_with_object({}) { |e, o| o[e] = send(e) }
  end
end
