defmodule Stripe.Issuing.Transaction do
  use Stripe.Entity

  @moduledoc "Any use of an [issued card](https://stripe.com/docs/issuing) that results in funds entering or leaving\nyour Stripe account, such as a completed purchase or refund, is represented by an Issuing\n`Transaction` object.\n\nRelated guide: [Issued card transactions](https://stripe.com/docs/issuing/purchases/transactions)"
  (
    defstruct [
      :amount,
      :amount_details,
      :authorization,
      :balance_transaction,
      :card,
      :cardholder,
      :created,
      :currency,
      :dispute,
      :id,
      :livemode,
      :merchant_amount,
      :merchant_currency,
      :merchant_data,
      :metadata,
      :network_data,
      :object,
      :purchase_details,
      :token,
      :treasury,
      :type,
      :wallet
    ]

    @typedoc "The `issuing.transaction` type.\n\n  * `amount` The transaction amount, which will be reflected in your balance. This amount is in your currency and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `amount_details` Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `authorization` The `Authorization` object that led to this transaction.\n  * `balance_transaction` ID of the [balance transaction](https://stripe.com/docs/api/balance_transactions) associated with this transaction.\n  * `card` The card used to make this transaction.\n  * `cardholder` The cardholder to whom this transaction belongs.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `dispute` If you've disputed the transaction, the ID of the dispute.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `merchant_amount` The amount that the merchant will receive, denominated in `merchant_currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). It will be different from `amount` if the merchant is taking payment in a different currency.\n  * `merchant_currency` The currency with which the merchant is taking payment.\n  * `merchant_data` \n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `network_data` Details about the transaction, such as processing dates, set by the card network.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `purchase_details` Additional purchase information that is optionally provided by the merchant.\n  * `token` [Token](https://stripe.com/docs/api/issuing/tokens/object) object used for this transaction. If a network token was not used for this transaction, this field will be null.\n  * `treasury` [Treasury](https://stripe.com/docs/api/treasury) details related to this transaction if it was created on a [FinancialAccount](/docs/api/treasury/financial_accounts\n  * `type` The nature of the transaction.\n  * `wallet` The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_details: term | nil,
            authorization: (binary | Stripe.Issuing.Authorization.t()) | nil,
            balance_transaction: (binary | Stripe.BalanceTransaction.t()) | nil,
            card: binary | Stripe.Issuing.Card.t(),
            cardholder: (binary | Stripe.Issuing.Cardholder.t()) | nil,
            created: integer,
            currency: binary,
            dispute: (binary | Stripe.Issuing.Dispute.t()) | nil,
            id: binary,
            livemode: boolean,
            merchant_amount: integer,
            merchant_currency: binary,
            merchant_data: term,
            metadata: term,
            network_data: term | nil,
            object: binary,
            purchase_details: term | nil,
            token: (binary | Stripe.Issuing.Token.t()) | nil,
            treasury: term | nil,
            type: binary,
            wallet: binary | nil
          }
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
    @typedoc "Information about the flight that was purchased with this transaction."
    @type flight :: %{
            optional(:departure_at) => integer,
            optional(:passenger_name) => binary,
            optional(:refundable) => boolean,
            optional(:segments) => list(segments),
            optional(:travel_agency) => binary
          }
  )

  (
    @typedoc "Information about fuel that was purchased with this transaction."
    @type fuel :: %{
            optional(:type) =>
              :diesel | :other | :unleaded_plus | :unleaded_regular | :unleaded_super,
            optional(:unit) => :liter | :us_gallon,
            optional(:unit_cost_decimal) => binary,
            optional(:volume_decimal) => binary
          }
  )

  (
    @typedoc "Information about lodging that was purchased with this transaction."
    @type lodging :: %{optional(:check_in_at) => integer, optional(:nights) => integer}
  )

  (
    @typedoc "Details about the seller (grocery store, e-commerce website, etc.) where the card authorization happened."
    @type merchant_data :: %{
            optional(:category) =>
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
              | :wrecking_and_salvage_yards,
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:name) => binary,
            optional(:network_id) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary,
            optional(:terminal_id) => binary,
            optional(:url) => binary
          }
  )

  (
    @typedoc "Additional purchase information that is optionally provided by the merchant."
    @type purchase_details :: %{
            optional(:flight) => flight,
            optional(:fuel) => fuel,
            optional(:lodging) => lodging,
            optional(:receipt) => list(receipt),
            optional(:reference) => binary
          }
  )

  (
    @typedoc nil
    @type receipt :: %{
            optional(:description) => binary,
            optional(:quantity) => binary,
            optional(:total) => integer,
            optional(:unit_cost) => integer
          }
  )

  (
    @typedoc nil
    @type segments :: %{
            optional(:arrival_airport_code) => binary,
            optional(:carrier) => binary,
            optional(:departure_airport_code) => binary,
            optional(:flight_number) => binary,
            optional(:service_class) => binary,
            optional(:stopover_allowed) => boolean
          }
  )

  (
    nil

    @doc "<p>Returns a list of Issuing <code>Transaction</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/transactions`\n"
    (
      @spec list(
              params :: %{
                optional(:card) => binary,
                optional(:cardholder) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:type) => :capture | :refund
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Transaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/transactions", [], [])

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

    @doc "<p>Retrieves an Issuing <code>Transaction</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/transactions/{transaction}`\n"
    (
      @spec retrieve(
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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

    @doc "<p>Updates the specified Issuing <code>Transaction</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/transactions/{transaction}`\n"
    (
      @spec update(
              transaction :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/transactions/{transaction}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
          )

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

    @doc "<p>Allows the user to capture an arbitrary amount, also known as a forced capture.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/transactions/create_force_capture`\n"
    (
      @spec create_force_capture(
              params :: %{
                optional(:amount) => integer,
                optional(:card) => binary,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:merchant_data) => merchant_data,
                optional(:purchase_details) => purchase_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create_force_capture(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/transactions/create_force_capture",
            [],
            []
          )

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

    @doc "<p>Allows the user to refund an arbitrary amount, also known as a unlinked refund.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/transactions/create_unlinked_refund`\n"
    (
      @spec create_unlinked_refund(
              params :: %{
                optional(:amount) => integer,
                optional(:card) => binary,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:merchant_data) => merchant_data,
                optional(:purchase_details) => purchase_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create_unlinked_refund(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/transactions/create_unlinked_refund",
            [],
            []
          )

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

    @doc "<p>Refund a test-mode Transaction.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/transactions/{transaction}/refund`\n"
    (
      @spec refund(
              transaction :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:refund_amount) => integer},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Transaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def refund(transaction, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/transactions/{transaction}/refund",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "transaction",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "transaction",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [transaction]
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
