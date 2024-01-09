defmodule Stripe.Issuing.Cardholder do
  use Stripe.Entity

  @moduledoc "An Issuing `Cardholder` object represents an individual or business entity who is [issued](https://stripe.com/docs/issuing) cards.\n\nRelated guide: [How to create a cardholder](https://stripe.com/docs/issuing/cards#create-cardholder)"
  (
    defstruct [
      :billing,
      :company,
      :created,
      :email,
      :id,
      :individual,
      :livemode,
      :metadata,
      :name,
      :object,
      :phone_number,
      :preferred_locales,
      :requirements,
      :spending_controls,
      :status,
      :type
    ]

    @typedoc "The `issuing.cardholder` type.\n\n  * `billing` \n  * `company` Additional information about a `company` cardholder.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `email` The cardholder's email address.\n  * `id` Unique identifier for the object.\n  * `individual` Additional information about an `individual` cardholder.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` The cardholder's name. This will be printed on cards issued to them.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `phone_number` The cardholder's phone number. This is required for all cardholders who will be creating EU cards. See the [3D Secure documentation](https://stripe.com/docs/issuing/3d-secure#when-is-3d-secure-applied) for more details.\n  * `preferred_locales` The cardholder’s preferred locales (languages), ordered by preference. Locales can be `de`, `en`, `es`, `fr`, or `it`.\n This changes the language of the [3D Secure flow](https://stripe.com/docs/issuing/3d-secure) and one-time password messages sent to the cardholder.\n  * `requirements` \n  * `spending_controls` Rules that control spending across this cardholder's cards. Refer to our [documentation](https://stripe.com/docs/issuing/controls/spending-controls) for more details.\n  * `status` Specifies whether to permit authorizations on this cardholder's cards.\n  * `type` One of `individual` or `company`. See [Choose a cardholder type](https://stripe.com/docs/issuing/other/choose-cardholder) for more details.\n"
    @type t :: %__MODULE__{
            billing: term,
            company: term | nil,
            created: integer,
            email: binary | nil,
            id: binary,
            individual: term | nil,
            livemode: boolean,
            metadata: term,
            name: binary,
            object: binary,
            phone_number: binary | nil,
            preferred_locales: term | nil,
            requirements: term,
            spending_controls: term | nil,
            status: binary,
            type: binary
          }
  )

  (
    @typedoc "The cardholder’s billing address."
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc "The cardholder's billing address."
    @type billing :: %{optional(:address) => address}
  )

  (
    @typedoc "Information related to the card_issuing program for this cardholder."
    @type card_issuing :: %{optional(:user_terms_acceptance) => user_terms_acceptance}
  )

  (
    @typedoc "Additional information about a `company` cardholder."
    @type company :: %{optional(:tax_id) => binary}
  )

  (
    @typedoc nil
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc "The date of birth of this cardholder. Cardholders must be older than 13 years old."
    @type dob :: %{
            optional(:day) => integer,
            optional(:month) => integer,
            optional(:year) => integer
          }
  )

  (
    @typedoc "An identifying document, either a passport or local ID card."
    @type document :: %{optional(:back) => binary, optional(:front) => binary}
  )

  (
    @typedoc "Additional information about an `individual` cardholder."
    @type individual :: %{
            optional(:card_issuing) => card_issuing,
            optional(:dob) => dob,
            optional(:first_name) => binary,
            optional(:last_name) => binary,
            optional(:verification) => verification
          }
  )

  (
    @typedoc "Rules that control spending across this cardholder's cards. Refer to our [documentation](https://stripe.com/docs/issuing/controls/spending-controls) for more details."
    @type spending_controls :: %{
            optional(:allowed_categories) =>
              list(
                :ac_refrigeration_repair
                | :accounting_bookkeeping_services
                | :advertising_services
                | :agricultural_cooperative
                | :airlines_air_carriers
                | :airports_flying_fields
                | :ambulance_services
                | :amusement_parks_carnivals
                | :antique_reproductions
                | :antique_shops
                | :aquariums
                | :architectural_surveying_services
                | :art_dealers_and_galleries
                | :artists_supply_and_craft_shops
                | :auto_and_home_supply_stores
                | :auto_body_repair_shops
                | :auto_paint_shops
                | :auto_service_shops
                | :automated_cash_disburse
                | :automated_fuel_dispensers
                | :automobile_associations
                | :automotive_parts_and_accessories_stores
                | :automotive_tire_stores
                | :bail_and_bond_payments
                | :bakeries
                | :bands_orchestras
                | :barber_and_beauty_shops
                | :betting_casino_gambling
                | :bicycle_shops
                | :billiard_pool_establishments
                | :boat_dealers
                | :boat_rentals_and_leases
                | :book_stores
                | :books_periodicals_and_newspapers
                | :bowling_alleys
                | :bus_lines
                | :business_secretarial_schools
                | :buying_shopping_services
                | :cable_satellite_and_other_pay_television_and_radio
                | :camera_and_photographic_supply_stores
                | :candy_nut_and_confectionery_stores
                | :car_and_truck_dealers_new_used
                | :car_and_truck_dealers_used_only
                | :car_rental_agencies
                | :car_washes
                | :carpentry_services
                | :carpet_upholstery_cleaning
                | :caterers
                | :charitable_and_social_service_organizations_fundraising
                | :chemicals_and_allied_products
                | :child_care_services
                | :childrens_and_infants_wear_stores
                | :chiropodists_podiatrists
                | :chiropractors
                | :cigar_stores_and_stands
                | :civic_social_fraternal_associations
                | :cleaning_and_maintenance
                | :clothing_rental
                | :colleges_universities
                | :commercial_equipment
                | :commercial_footwear
                | :commercial_photography_art_and_graphics
                | :commuter_transport_and_ferries
                | :computer_network_services
                | :computer_programming
                | :computer_repair
                | :computer_software_stores
                | :computers_peripherals_and_software
                | :concrete_work_services
                | :construction_materials
                | :consulting_public_relations
                | :correspondence_schools
                | :cosmetic_stores
                | :counseling_services
                | :country_clubs
                | :courier_services
                | :court_costs
                | :credit_reporting_agencies
                | :cruise_lines
                | :dairy_products_stores
                | :dance_hall_studios_schools
                | :dating_escort_services
                | :dentists_orthodontists
                | :department_stores
                | :detective_agencies
                | :digital_goods_applications
                | :digital_goods_games
                | :digital_goods_large_volume
                | :digital_goods_media
                | :direct_marketing_catalog_merchant
                | :direct_marketing_combination_catalog_and_retail_merchant
                | :direct_marketing_inbound_telemarketing
                | :direct_marketing_insurance_services
                | :direct_marketing_other
                | :direct_marketing_outbound_telemarketing
                | :direct_marketing_subscription
                | :direct_marketing_travel
                | :discount_stores
                | :doctors
                | :door_to_door_sales
                | :drapery_window_covering_and_upholstery_stores
                | :drinking_places
                | :drug_stores_and_pharmacies
                | :drugs_drug_proprietaries_and_druggist_sundries
                | :dry_cleaners
                | :durable_goods
                | :duty_free_stores
                | :eating_places_restaurants
                | :educational_services
                | :electric_razor_stores
                | :electric_vehicle_charging
                | :electrical_parts_and_equipment
                | :electrical_services
                | :electronics_repair_shops
                | :electronics_stores
                | :elementary_secondary_schools
                | :emergency_services_gcas_visa_use_only
                | :employment_temp_agencies
                | :equipment_rental
                | :exterminating_services
                | :family_clothing_stores
                | :fast_food_restaurants
                | :financial_institutions
                | :fines_government_administrative_entities
                | :fireplace_fireplace_screens_and_accessories_stores
                | :floor_covering_stores
                | :florists
                | :florists_supplies_nursery_stock_and_flowers
                | :freezer_and_locker_meat_provisioners
                | :fuel_dealers_non_automotive
                | :funeral_services_crematories
                | :furniture_home_furnishings_and_equipment_stores_except_appliances
                | :furniture_repair_refinishing
                | :furriers_and_fur_shops
                | :general_services
                | :gift_card_novelty_and_souvenir_shops
                | :glass_paint_and_wallpaper_stores
                | :glassware_crystal_stores
                | :golf_courses_public
                | :government_licensed_horse_dog_racing_us_region_only
                | :government_licensed_online_casions_online_gambling_us_region_only
                | :government_owned_lotteries_non_us_region
                | :government_owned_lotteries_us_region_only
                | :government_services
                | :grocery_stores_supermarkets
                | :hardware_equipment_and_supplies
                | :hardware_stores
                | :health_and_beauty_spas
                | :hearing_aids_sales_and_supplies
                | :heating_plumbing_a_c
                | :hobby_toy_and_game_shops
                | :home_supply_warehouse_stores
                | :hospitals
                | :hotels_motels_and_resorts
                | :household_appliance_stores
                | :industrial_supplies
                | :information_retrieval_services
                | :insurance_default
                | :insurance_underwriting_premiums
                | :intra_company_purchases
                | :jewelry_stores_watches_clocks_and_silverware_stores
                | :landscaping_services
                | :laundries
                | :laundry_cleaning_services
                | :legal_services_attorneys
                | :luggage_and_leather_goods_stores
                | :lumber_building_materials_stores
                | :manual_cash_disburse
                | :marinas_service_and_supplies
                | :marketplaces
                | :masonry_stonework_and_plaster
                | :massage_parlors
                | :medical_and_dental_labs
                | :medical_dental_ophthalmic_and_hospital_equipment_and_supplies
                | :medical_services
                | :membership_organizations
                | :mens_and_boys_clothing_and_accessories_stores
                | :mens_womens_clothing_stores
                | :metal_service_centers
                | :miscellaneous
                | :miscellaneous_apparel_and_accessory_shops
                | :miscellaneous_auto_dealers
                | :miscellaneous_business_services
                | :miscellaneous_food_stores
                | :miscellaneous_general_merchandise
                | :miscellaneous_general_services
                | :miscellaneous_home_furnishing_specialty_stores
                | :miscellaneous_publishing_and_printing
                | :miscellaneous_recreation_services
                | :miscellaneous_repair_shops
                | :miscellaneous_specialty_retail
                | :mobile_home_dealers
                | :motion_picture_theaters
                | :motor_freight_carriers_and_trucking
                | :motor_homes_dealers
                | :motor_vehicle_supplies_and_new_parts
                | :motorcycle_shops_and_dealers
                | :motorcycle_shops_dealers
                | :music_stores_musical_instruments_pianos_and_sheet_music
                | :news_dealers_and_newsstands
                | :non_fi_money_orders
                | :non_fi_stored_value_card_purchase_load
                | :nondurable_goods
                | :nurseries_lawn_and_garden_supply_stores
                | :nursing_personal_care
                | :office_and_commercial_furniture
                | :opticians_eyeglasses
                | :optometrists_ophthalmologist
                | :orthopedic_goods_prosthetic_devices
                | :osteopaths
                | :package_stores_beer_wine_and_liquor
                | :paints_varnishes_and_supplies
                | :parking_lots_garages
                | :passenger_railways
                | :pawn_shops
                | :pet_shops_pet_food_and_supplies
                | :petroleum_and_petroleum_products
                | :photo_developing
                | :photographic_photocopy_microfilm_equipment_and_supplies
                | :photographic_studios
                | :picture_video_production
                | :piece_goods_notions_and_other_dry_goods
                | :plumbing_heating_equipment_and_supplies
                | :political_organizations
                | :postal_services_government_only
                | :precious_stones_and_metals_watches_and_jewelry
                | :professional_services
                | :public_warehousing_and_storage
                | :quick_copy_repro_and_blueprint
                | :railroads
                | :real_estate_agents_and_managers_rentals
                | :record_stores
                | :recreational_vehicle_rentals
                | :religious_goods_stores
                | :religious_organizations
                | :roofing_siding_sheet_metal
                | :secretarial_support_services
                | :security_brokers_dealers
                | :service_stations
                | :sewing_needlework_fabric_and_piece_goods_stores
                | :shoe_repair_hat_cleaning
                | :shoe_stores
                | :small_appliance_repair
                | :snowmobile_dealers
                | :special_trade_services
                | :specialty_cleaning
                | :sporting_goods_stores
                | :sporting_recreation_camps
                | :sports_and_riding_apparel_stores
                | :sports_clubs_fields
                | :stamp_and_coin_stores
                | :stationary_office_supplies_printing_and_writing_paper
                | :stationery_stores_office_and_school_supply_stores
                | :swimming_pools_sales
                | :t_ui_travel_germany
                | :tailors_alterations
                | :tax_payments_government_agencies
                | :tax_preparation_services
                | :taxicabs_limousines
                | :telecommunication_equipment_and_telephone_sales
                | :telecommunication_services
                | :telegraph_services
                | :tent_and_awning_shops
                | :testing_laboratories
                | :theatrical_ticket_agencies
                | :timeshares
                | :tire_retreading_and_repair
                | :tolls_bridge_fees
                | :tourist_attractions_and_exhibits
                | :towing_services
                | :trailer_parks_campgrounds
                | :transportation_services
                | :travel_agencies_tour_operators
                | :truck_stop_iteration
                | :truck_utility_trailer_rentals
                | :typesetting_plate_making_and_related_services
                | :typewriter_stores
                | :u_s_federal_government_agencies_or_departments
                | :uniforms_commercial_clothing
                | :used_merchandise_and_secondhand_stores
                | :utilities
                | :variety_stores
                | :veterinary_services
                | :video_amusement_game_supplies
                | :video_game_arcades
                | :video_tape_rental_stores
                | :vocational_trade_schools
                | :watch_jewelry_repair
                | :welding_repair
                | :wholesale_clubs
                | :wig_and_toupee_stores
                | :wires_money_orders
                | :womens_accessory_and_specialty_shops
                | :womens_ready_to_wear_stores
                | :wrecking_and_salvage_yards
              ),
            optional(:blocked_categories) =>
              list(
                :ac_refrigeration_repair
                | :accounting_bookkeeping_services
                | :advertising_services
                | :agricultural_cooperative
                | :airlines_air_carriers
                | :airports_flying_fields
                | :ambulance_services
                | :amusement_parks_carnivals
                | :antique_reproductions
                | :antique_shops
                | :aquariums
                | :architectural_surveying_services
                | :art_dealers_and_galleries
                | :artists_supply_and_craft_shops
                | :auto_and_home_supply_stores
                | :auto_body_repair_shops
                | :auto_paint_shops
                | :auto_service_shops
                | :automated_cash_disburse
                | :automated_fuel_dispensers
                | :automobile_associations
                | :automotive_parts_and_accessories_stores
                | :automotive_tire_stores
                | :bail_and_bond_payments
                | :bakeries
                | :bands_orchestras
                | :barber_and_beauty_shops
                | :betting_casino_gambling
                | :bicycle_shops
                | :billiard_pool_establishments
                | :boat_dealers
                | :boat_rentals_and_leases
                | :book_stores
                | :books_periodicals_and_newspapers
                | :bowling_alleys
                | :bus_lines
                | :business_secretarial_schools
                | :buying_shopping_services
                | :cable_satellite_and_other_pay_television_and_radio
                | :camera_and_photographic_supply_stores
                | :candy_nut_and_confectionery_stores
                | :car_and_truck_dealers_new_used
                | :car_and_truck_dealers_used_only
                | :car_rental_agencies
                | :car_washes
                | :carpentry_services
                | :carpet_upholstery_cleaning
                | :caterers
                | :charitable_and_social_service_organizations_fundraising
                | :chemicals_and_allied_products
                | :child_care_services
                | :childrens_and_infants_wear_stores
                | :chiropodists_podiatrists
                | :chiropractors
                | :cigar_stores_and_stands
                | :civic_social_fraternal_associations
                | :cleaning_and_maintenance
                | :clothing_rental
                | :colleges_universities
                | :commercial_equipment
                | :commercial_footwear
                | :commercial_photography_art_and_graphics
                | :commuter_transport_and_ferries
                | :computer_network_services
                | :computer_programming
                | :computer_repair
                | :computer_software_stores
                | :computers_peripherals_and_software
                | :concrete_work_services
                | :construction_materials
                | :consulting_public_relations
                | :correspondence_schools
                | :cosmetic_stores
                | :counseling_services
                | :country_clubs
                | :courier_services
                | :court_costs
                | :credit_reporting_agencies
                | :cruise_lines
                | :dairy_products_stores
                | :dance_hall_studios_schools
                | :dating_escort_services
                | :dentists_orthodontists
                | :department_stores
                | :detective_agencies
                | :digital_goods_applications
                | :digital_goods_games
                | :digital_goods_large_volume
                | :digital_goods_media
                | :direct_marketing_catalog_merchant
                | :direct_marketing_combination_catalog_and_retail_merchant
                | :direct_marketing_inbound_telemarketing
                | :direct_marketing_insurance_services
                | :direct_marketing_other
                | :direct_marketing_outbound_telemarketing
                | :direct_marketing_subscription
                | :direct_marketing_travel
                | :discount_stores
                | :doctors
                | :door_to_door_sales
                | :drapery_window_covering_and_upholstery_stores
                | :drinking_places
                | :drug_stores_and_pharmacies
                | :drugs_drug_proprietaries_and_druggist_sundries
                | :dry_cleaners
                | :durable_goods
                | :duty_free_stores
                | :eating_places_restaurants
                | :educational_services
                | :electric_razor_stores
                | :electric_vehicle_charging
                | :electrical_parts_and_equipment
                | :electrical_services
                | :electronics_repair_shops
                | :electronics_stores
                | :elementary_secondary_schools
                | :emergency_services_gcas_visa_use_only
                | :employment_temp_agencies
                | :equipment_rental
                | :exterminating_services
                | :family_clothing_stores
                | :fast_food_restaurants
                | :financial_institutions
                | :fines_government_administrative_entities
                | :fireplace_fireplace_screens_and_accessories_stores
                | :floor_covering_stores
                | :florists
                | :florists_supplies_nursery_stock_and_flowers
                | :freezer_and_locker_meat_provisioners
                | :fuel_dealers_non_automotive
                | :funeral_services_crematories
                | :furniture_home_furnishings_and_equipment_stores_except_appliances
                | :furniture_repair_refinishing
                | :furriers_and_fur_shops
                | :general_services
                | :gift_card_novelty_and_souvenir_shops
                | :glass_paint_and_wallpaper_stores
                | :glassware_crystal_stores
                | :golf_courses_public
                | :government_licensed_horse_dog_racing_us_region_only
                | :government_licensed_online_casions_online_gambling_us_region_only
                | :government_owned_lotteries_non_us_region
                | :government_owned_lotteries_us_region_only
                | :government_services
                | :grocery_stores_supermarkets
                | :hardware_equipment_and_supplies
                | :hardware_stores
                | :health_and_beauty_spas
                | :hearing_aids_sales_and_supplies
                | :heating_plumbing_a_c
                | :hobby_toy_and_game_shops
                | :home_supply_warehouse_stores
                | :hospitals
                | :hotels_motels_and_resorts
                | :household_appliance_stores
                | :industrial_supplies
                | :information_retrieval_services
                | :insurance_default
                | :insurance_underwriting_premiums
                | :intra_company_purchases
                | :jewelry_stores_watches_clocks_and_silverware_stores
                | :landscaping_services
                | :laundries
                | :laundry_cleaning_services
                | :legal_services_attorneys
                | :luggage_and_leather_goods_stores
                | :lumber_building_materials_stores
                | :manual_cash_disburse
                | :marinas_service_and_supplies
                | :marketplaces
                | :masonry_stonework_and_plaster
                | :massage_parlors
                | :medical_and_dental_labs
                | :medical_dental_ophthalmic_and_hospital_equipment_and_supplies
                | :medical_services
                | :membership_organizations
                | :mens_and_boys_clothing_and_accessories_stores
                | :mens_womens_clothing_stores
                | :metal_service_centers
                | :miscellaneous
                | :miscellaneous_apparel_and_accessory_shops
                | :miscellaneous_auto_dealers
                | :miscellaneous_business_services
                | :miscellaneous_food_stores
                | :miscellaneous_general_merchandise
                | :miscellaneous_general_services
                | :miscellaneous_home_furnishing_specialty_stores
                | :miscellaneous_publishing_and_printing
                | :miscellaneous_recreation_services
                | :miscellaneous_repair_shops
                | :miscellaneous_specialty_retail
                | :mobile_home_dealers
                | :motion_picture_theaters
                | :motor_freight_carriers_and_trucking
                | :motor_homes_dealers
                | :motor_vehicle_supplies_and_new_parts
                | :motorcycle_shops_and_dealers
                | :motorcycle_shops_dealers
                | :music_stores_musical_instruments_pianos_and_sheet_music
                | :news_dealers_and_newsstands
                | :non_fi_money_orders
                | :non_fi_stored_value_card_purchase_load
                | :nondurable_goods
                | :nurseries_lawn_and_garden_supply_stores
                | :nursing_personal_care
                | :office_and_commercial_furniture
                | :opticians_eyeglasses
                | :optometrists_ophthalmologist
                | :orthopedic_goods_prosthetic_devices
                | :osteopaths
                | :package_stores_beer_wine_and_liquor
                | :paints_varnishes_and_supplies
                | :parking_lots_garages
                | :passenger_railways
                | :pawn_shops
                | :pet_shops_pet_food_and_supplies
                | :petroleum_and_petroleum_products
                | :photo_developing
                | :photographic_photocopy_microfilm_equipment_and_supplies
                | :photographic_studios
                | :picture_video_production
                | :piece_goods_notions_and_other_dry_goods
                | :plumbing_heating_equipment_and_supplies
                | :political_organizations
                | :postal_services_government_only
                | :precious_stones_and_metals_watches_and_jewelry
                | :professional_services
                | :public_warehousing_and_storage
                | :quick_copy_repro_and_blueprint
                | :railroads
                | :real_estate_agents_and_managers_rentals
                | :record_stores
                | :recreational_vehicle_rentals
                | :religious_goods_stores
                | :religious_organizations
                | :roofing_siding_sheet_metal
                | :secretarial_support_services
                | :security_brokers_dealers
                | :service_stations
                | :sewing_needlework_fabric_and_piece_goods_stores
                | :shoe_repair_hat_cleaning
                | :shoe_stores
                | :small_appliance_repair
                | :snowmobile_dealers
                | :special_trade_services
                | :specialty_cleaning
                | :sporting_goods_stores
                | :sporting_recreation_camps
                | :sports_and_riding_apparel_stores
                | :sports_clubs_fields
                | :stamp_and_coin_stores
                | :stationary_office_supplies_printing_and_writing_paper
                | :stationery_stores_office_and_school_supply_stores
                | :swimming_pools_sales
                | :t_ui_travel_germany
                | :tailors_alterations
                | :tax_payments_government_agencies
                | :tax_preparation_services
                | :taxicabs_limousines
                | :telecommunication_equipment_and_telephone_sales
                | :telecommunication_services
                | :telegraph_services
                | :tent_and_awning_shops
                | :testing_laboratories
                | :theatrical_ticket_agencies
                | :timeshares
                | :tire_retreading_and_repair
                | :tolls_bridge_fees
                | :tourist_attractions_and_exhibits
                | :towing_services
                | :trailer_parks_campgrounds
                | :transportation_services
                | :travel_agencies_tour_operators
                | :truck_stop_iteration
                | :truck_utility_trailer_rentals
                | :typesetting_plate_making_and_related_services
                | :typewriter_stores
                | :u_s_federal_government_agencies_or_departments
                | :uniforms_commercial_clothing
                | :used_merchandise_and_secondhand_stores
                | :utilities
                | :variety_stores
                | :veterinary_services
                | :video_amusement_game_supplies
                | :video_game_arcades
                | :video_tape_rental_stores
                | :vocational_trade_schools
                | :watch_jewelry_repair
                | :welding_repair
                | :wholesale_clubs
                | :wig_and_toupee_stores
                | :wires_money_orders
                | :womens_accessory_and_specialty_shops
                | :womens_ready_to_wear_stores
                | :wrecking_and_salvage_yards
              ),
            optional(:spending_limits) => list(spending_limits),
            optional(:spending_limits_currency) => binary
          }
  )

  (
    @typedoc nil
    @type spending_limits :: %{
            optional(:amount) => integer,
            optional(:categories) =>
              list(
                :ac_refrigeration_repair
                | :accounting_bookkeeping_services
                | :advertising_services
                | :agricultural_cooperative
                | :airlines_air_carriers
                | :airports_flying_fields
                | :ambulance_services
                | :amusement_parks_carnivals
                | :antique_reproductions
                | :antique_shops
                | :aquariums
                | :architectural_surveying_services
                | :art_dealers_and_galleries
                | :artists_supply_and_craft_shops
                | :auto_and_home_supply_stores
                | :auto_body_repair_shops
                | :auto_paint_shops
                | :auto_service_shops
                | :automated_cash_disburse
                | :automated_fuel_dispensers
                | :automobile_associations
                | :automotive_parts_and_accessories_stores
                | :automotive_tire_stores
                | :bail_and_bond_payments
                | :bakeries
                | :bands_orchestras
                | :barber_and_beauty_shops
                | :betting_casino_gambling
                | :bicycle_shops
                | :billiard_pool_establishments
                | :boat_dealers
                | :boat_rentals_and_leases
                | :book_stores
                | :books_periodicals_and_newspapers
                | :bowling_alleys
                | :bus_lines
                | :business_secretarial_schools
                | :buying_shopping_services
                | :cable_satellite_and_other_pay_television_and_radio
                | :camera_and_photographic_supply_stores
                | :candy_nut_and_confectionery_stores
                | :car_and_truck_dealers_new_used
                | :car_and_truck_dealers_used_only
                | :car_rental_agencies
                | :car_washes
                | :carpentry_services
                | :carpet_upholstery_cleaning
                | :caterers
                | :charitable_and_social_service_organizations_fundraising
                | :chemicals_and_allied_products
                | :child_care_services
                | :childrens_and_infants_wear_stores
                | :chiropodists_podiatrists
                | :chiropractors
                | :cigar_stores_and_stands
                | :civic_social_fraternal_associations
                | :cleaning_and_maintenance
                | :clothing_rental
                | :colleges_universities
                | :commercial_equipment
                | :commercial_footwear
                | :commercial_photography_art_and_graphics
                | :commuter_transport_and_ferries
                | :computer_network_services
                | :computer_programming
                | :computer_repair
                | :computer_software_stores
                | :computers_peripherals_and_software
                | :concrete_work_services
                | :construction_materials
                | :consulting_public_relations
                | :correspondence_schools
                | :cosmetic_stores
                | :counseling_services
                | :country_clubs
                | :courier_services
                | :court_costs
                | :credit_reporting_agencies
                | :cruise_lines
                | :dairy_products_stores
                | :dance_hall_studios_schools
                | :dating_escort_services
                | :dentists_orthodontists
                | :department_stores
                | :detective_agencies
                | :digital_goods_applications
                | :digital_goods_games
                | :digital_goods_large_volume
                | :digital_goods_media
                | :direct_marketing_catalog_merchant
                | :direct_marketing_combination_catalog_and_retail_merchant
                | :direct_marketing_inbound_telemarketing
                | :direct_marketing_insurance_services
                | :direct_marketing_other
                | :direct_marketing_outbound_telemarketing
                | :direct_marketing_subscription
                | :direct_marketing_travel
                | :discount_stores
                | :doctors
                | :door_to_door_sales
                | :drapery_window_covering_and_upholstery_stores
                | :drinking_places
                | :drug_stores_and_pharmacies
                | :drugs_drug_proprietaries_and_druggist_sundries
                | :dry_cleaners
                | :durable_goods
                | :duty_free_stores
                | :eating_places_restaurants
                | :educational_services
                | :electric_razor_stores
                | :electric_vehicle_charging
                | :electrical_parts_and_equipment
                | :electrical_services
                | :electronics_repair_shops
                | :electronics_stores
                | :elementary_secondary_schools
                | :emergency_services_gcas_visa_use_only
                | :employment_temp_agencies
                | :equipment_rental
                | :exterminating_services
                | :family_clothing_stores
                | :fast_food_restaurants
                | :financial_institutions
                | :fines_government_administrative_entities
                | :fireplace_fireplace_screens_and_accessories_stores
                | :floor_covering_stores
                | :florists
                | :florists_supplies_nursery_stock_and_flowers
                | :freezer_and_locker_meat_provisioners
                | :fuel_dealers_non_automotive
                | :funeral_services_crematories
                | :furniture_home_furnishings_and_equipment_stores_except_appliances
                | :furniture_repair_refinishing
                | :furriers_and_fur_shops
                | :general_services
                | :gift_card_novelty_and_souvenir_shops
                | :glass_paint_and_wallpaper_stores
                | :glassware_crystal_stores
                | :golf_courses_public
                | :government_licensed_horse_dog_racing_us_region_only
                | :government_licensed_online_casions_online_gambling_us_region_only
                | :government_owned_lotteries_non_us_region
                | :government_owned_lotteries_us_region_only
                | :government_services
                | :grocery_stores_supermarkets
                | :hardware_equipment_and_supplies
                | :hardware_stores
                | :health_and_beauty_spas
                | :hearing_aids_sales_and_supplies
                | :heating_plumbing_a_c
                | :hobby_toy_and_game_shops
                | :home_supply_warehouse_stores
                | :hospitals
                | :hotels_motels_and_resorts
                | :household_appliance_stores
                | :industrial_supplies
                | :information_retrieval_services
                | :insurance_default
                | :insurance_underwriting_premiums
                | :intra_company_purchases
                | :jewelry_stores_watches_clocks_and_silverware_stores
                | :landscaping_services
                | :laundries
                | :laundry_cleaning_services
                | :legal_services_attorneys
                | :luggage_and_leather_goods_stores
                | :lumber_building_materials_stores
                | :manual_cash_disburse
                | :marinas_service_and_supplies
                | :marketplaces
                | :masonry_stonework_and_plaster
                | :massage_parlors
                | :medical_and_dental_labs
                | :medical_dental_ophthalmic_and_hospital_equipment_and_supplies
                | :medical_services
                | :membership_organizations
                | :mens_and_boys_clothing_and_accessories_stores
                | :mens_womens_clothing_stores
                | :metal_service_centers
                | :miscellaneous
                | :miscellaneous_apparel_and_accessory_shops
                | :miscellaneous_auto_dealers
                | :miscellaneous_business_services
                | :miscellaneous_food_stores
                | :miscellaneous_general_merchandise
                | :miscellaneous_general_services
                | :miscellaneous_home_furnishing_specialty_stores
                | :miscellaneous_publishing_and_printing
                | :miscellaneous_recreation_services
                | :miscellaneous_repair_shops
                | :miscellaneous_specialty_retail
                | :mobile_home_dealers
                | :motion_picture_theaters
                | :motor_freight_carriers_and_trucking
                | :motor_homes_dealers
                | :motor_vehicle_supplies_and_new_parts
                | :motorcycle_shops_and_dealers
                | :motorcycle_shops_dealers
                | :music_stores_musical_instruments_pianos_and_sheet_music
                | :news_dealers_and_newsstands
                | :non_fi_money_orders
                | :non_fi_stored_value_card_purchase_load
                | :nondurable_goods
                | :nurseries_lawn_and_garden_supply_stores
                | :nursing_personal_care
                | :office_and_commercial_furniture
                | :opticians_eyeglasses
                | :optometrists_ophthalmologist
                | :orthopedic_goods_prosthetic_devices
                | :osteopaths
                | :package_stores_beer_wine_and_liquor
                | :paints_varnishes_and_supplies
                | :parking_lots_garages
                | :passenger_railways
                | :pawn_shops
                | :pet_shops_pet_food_and_supplies
                | :petroleum_and_petroleum_products
                | :photo_developing
                | :photographic_photocopy_microfilm_equipment_and_supplies
                | :photographic_studios
                | :picture_video_production
                | :piece_goods_notions_and_other_dry_goods
                | :plumbing_heating_equipment_and_supplies
                | :political_organizations
                | :postal_services_government_only
                | :precious_stones_and_metals_watches_and_jewelry
                | :professional_services
                | :public_warehousing_and_storage
                | :quick_copy_repro_and_blueprint
                | :railroads
                | :real_estate_agents_and_managers_rentals
                | :record_stores
                | :recreational_vehicle_rentals
                | :religious_goods_stores
                | :religious_organizations
                | :roofing_siding_sheet_metal
                | :secretarial_support_services
                | :security_brokers_dealers
                | :service_stations
                | :sewing_needlework_fabric_and_piece_goods_stores
                | :shoe_repair_hat_cleaning
                | :shoe_stores
                | :small_appliance_repair
                | :snowmobile_dealers
                | :special_trade_services
                | :specialty_cleaning
                | :sporting_goods_stores
                | :sporting_recreation_camps
                | :sports_and_riding_apparel_stores
                | :sports_clubs_fields
                | :stamp_and_coin_stores
                | :stationary_office_supplies_printing_and_writing_paper
                | :stationery_stores_office_and_school_supply_stores
                | :swimming_pools_sales
                | :t_ui_travel_germany
                | :tailors_alterations
                | :tax_payments_government_agencies
                | :tax_preparation_services
                | :taxicabs_limousines
                | :telecommunication_equipment_and_telephone_sales
                | :telecommunication_services
                | :telegraph_services
                | :tent_and_awning_shops
                | :testing_laboratories
                | :theatrical_ticket_agencies
                | :timeshares
                | :tire_retreading_and_repair
                | :tolls_bridge_fees
                | :tourist_attractions_and_exhibits
                | :towing_services
                | :trailer_parks_campgrounds
                | :transportation_services
                | :travel_agencies_tour_operators
                | :truck_stop_iteration
                | :truck_utility_trailer_rentals
                | :typesetting_plate_making_and_related_services
                | :typewriter_stores
                | :u_s_federal_government_agencies_or_departments
                | :uniforms_commercial_clothing
                | :used_merchandise_and_secondhand_stores
                | :utilities
                | :variety_stores
                | :veterinary_services
                | :video_amusement_game_supplies
                | :video_game_arcades
                | :video_tape_rental_stores
                | :vocational_trade_schools
                | :watch_jewelry_repair
                | :welding_repair
                | :wholesale_clubs
                | :wig_and_toupee_stores
                | :wires_money_orders
                | :womens_accessory_and_specialty_shops
                | :womens_ready_to_wear_stores
                | :wrecking_and_salvage_yards
              ),
            optional(:interval) =>
              :all_time | :daily | :monthly | :per_authorization | :weekly | :yearly
          }
  )

  (
    @typedoc "Information about cardholder acceptance of Celtic [Authorized User Terms](https://stripe.com/docs/issuing/cards#accept-authorized-user-terms). Required for cards backed by a Celtic program."
    @type user_terms_acceptance :: %{
            optional(:date) => integer,
            optional(:ip) => binary,
            optional(:user_agent) => binary | binary
          }
  )

  (
    @typedoc "Government-issued ID document for this cardholder."
    @type verification :: %{optional(:document) => document}
  )

  (
    nil

    @doc "<p>Returns a list of Issuing <code>Cardholder</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/cardholders`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:email) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:phone_number) => binary,
                optional(:starting_after) => binary,
                optional(:status) => :active | :blocked | :inactive,
                optional(:type) => :company | :individual
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Cardholder.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/cardholders", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Creates a new Issuing <code>Cardholder</code> object that can be issued cards.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/cardholders`\n"
    (
      @spec create(
              params :: %{
                optional(:billing) => billing,
                optional(:company) => company,
                optional(:email) => binary,
                optional(:expand) => list(binary),
                optional(:individual) => individual,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary,
                optional(:phone_number) => binary,
                optional(:preferred_locales) => list(:de | :en | :es | :fr | :it),
                optional(:spending_controls) => spending_controls,
                optional(:status) => :active | :inactive,
                optional(:type) => :company | :individual
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Cardholder.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/cardholders", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves an Issuing <code>Cardholder</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/cardholders/{cardholder}`\n"
    (
      @spec retrieve(
              cardholder :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Cardholder.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(cardholder, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/cardholders/{cardholder}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "cardholder",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "cardholder",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [cardholder]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Updates the specified Issuing <code>Cardholder</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/cardholders/{cardholder}`\n"
    (
      @spec update(
              cardholder :: binary(),
              params :: %{
                optional(:billing) => billing,
                optional(:company) => company,
                optional(:email) => binary,
                optional(:expand) => list(binary),
                optional(:individual) => individual,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:phone_number) => binary,
                optional(:preferred_locales) => list(:de | :en | :es | :fr | :it),
                optional(:spending_controls) => spending_controls,
                optional(:status) => :active | :inactive
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Cardholder.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(cardholder, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/cardholders/{cardholder}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "cardholder",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "cardholder",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [cardholder]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
