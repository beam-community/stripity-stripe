defmodule Stripe.Issuing.Authorization do
  use Stripe.Entity

  @moduledoc "When an [issued card](https://stripe.com/docs/issuing) is used to make a purchase, an Issuing `Authorization`\nobject is created. [Authorizations](https://stripe.com/docs/issuing/purchases/authorizations) must be approved for the\npurchase to be completed successfully.\n\nRelated guide: [Issued card authorizations](https://stripe.com/docs/issuing/purchases/authorizations)"
  (
    defstruct [
      :amount,
      :amount_details,
      :approved,
      :authorization_method,
      :balance_transactions,
      :card,
      :cardholder,
      :created,
      :currency,
      :id,
      :livemode,
      :merchant_amount,
      :merchant_currency,
      :merchant_data,
      :metadata,
      :network_data,
      :object,
      :pending_request,
      :request_history,
      :status,
      :token,
      :transactions,
      :treasury,
      :verification_data,
      :wallet
    ]

    @typedoc "The `issuing.authorization` type.\n\n  * `amount` The total amount that was authorized or rejected. This amount is in `currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). `amount` should be the same as `merchant_amount`, unless `currency` and `merchant_currency` are different.\n  * `amount_details` Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `approved` Whether the authorization has been approved.\n  * `authorization_method` How the card details were provided.\n  * `balance_transactions` List of balance transactions associated with this authorization.\n  * `card` \n  * `cardholder` The cardholder to whom this authorization belongs.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` The currency of the cardholder. This currency can be different from the currency presented at authorization and the `merchant_currency` field on this authorization. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `merchant_amount` The total amount that was authorized or rejected. This amount is in the `merchant_currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). `merchant_amount` should be the same as `amount`, unless `merchant_currency` and `currency` are different.\n  * `merchant_currency` The local currency that was presented to the cardholder for the authorization. This currency can be different from the cardholder currency and the `currency` field on this authorization. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `merchant_data` \n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `network_data` Details about the authorization, such as identifiers, set by the card network.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `pending_request` The pending authorization request. This field will only be non-null during an `issuing_authorization.request` webhook.\n  * `request_history` History of every time a `pending_request` authorization was approved/declined, either by you directly or by Stripe (e.g. based on your spending_controls). If the merchant changes the authorization by performing an incremental authorization, you can look at this field to see the previous requests for the authorization. This field can be helpful in determining why a given authorization was approved/declined.\n  * `status` The current status of the authorization in its lifecycle.\n  * `token` [Token](https://stripe.com/docs/api/issuing/tokens/object) object used for this authorization. If a network token was not used for this authorization, this field will be null.\n  * `transactions` List of [transactions](https://stripe.com/docs/api/issuing/transactions) associated with this authorization.\n  * `treasury` [Treasury](https://stripe.com/docs/api/treasury) details related to this authorization if it was created on a [FinancialAccount](https://stripe.com/docs/api/treasury/financial_accounts).\n  * `verification_data` \n  * `wallet` The digital wallet used for this transaction. One of `apple_pay`, `google_pay`, or `samsung_pay`. Will populate as `null` when no digital wallet was utilized.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_details: term | nil,
            approved: boolean,
            authorization_method: binary,
            balance_transactions: term,
            card: Stripe.Issuing.Card.t(),
            cardholder: (binary | Stripe.Issuing.Cardholder.t()) | nil,
            created: integer,
            currency: binary,
            id: binary,
            livemode: boolean,
            merchant_amount: integer,
            merchant_currency: binary,
            merchant_data: term,
            metadata: term,
            network_data: term | nil,
            object: binary,
            pending_request: term | nil,
            request_history: term,
            status: binary,
            token: (binary | Stripe.Issuing.Token.t()) | nil,
            transactions: term,
            treasury: term | nil,
            verification_data: term,
            wallet: binary | nil
          }
  )

  (
    @typedoc "Detailed breakdown of amount components. These amounts are denominated in `currency` and in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal)."
    @type amount_details :: %{
            optional(:atm_fee) => integer,
            optional(:cashback_amount) => integer
          }
  )

  (
    @typedoc "The exemption applied to this authorization."
    @type authentication_exemption :: %{
            optional(:claimed_by) => :acquirer | :issuer,
            optional(:type) => :low_value_transaction | :transaction_risk_analysis | :unknown
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
    @typedoc "Details about the authorization, such as identifiers, set by the card network."
    @type network_data :: %{optional(:acquiring_institution_id) => binary}
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
    @typedoc "3D Secure details."
    @type three_d_secure :: %{
            optional(:result) => :attempt_acknowledged | :authenticated | :failed | :required
          }
  )

  (
    @typedoc "Verifications that Stripe performed on information that the cardholder provided to the merchant."
    @type verification_data :: %{
            optional(:address_line1_check) => :match | :mismatch | :not_provided,
            optional(:address_postal_code_check) => :match | :mismatch | :not_provided,
            optional(:authentication_exemption) => authentication_exemption,
            optional(:cvc_check) => :match | :mismatch | :not_provided,
            optional(:expiry_check) => :match | :mismatch | :not_provided,
            optional(:three_d_secure) => three_d_secure
          }
  )

  (
    nil

    @doc "<p>Returns a list of Issuing <code>Authorization</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/authorizations`\n"
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
                optional(:status) => :closed | :pending | :reversed
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.Authorization.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/issuing/authorizations", [], [])

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

    @doc "<p>Retrieves an Issuing <code>Authorization</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/authorizations/{authorization}`\n"
    (
      @spec retrieve(
              authorization :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Updates the specified Issuing <code>Authorization</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/authorizations/{authorization}`\n"
    (
      @spec update(
              authorization :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>[Deprecated] Approves a pending Issuing <code>Authorization</code> object. This request should be made within the timeout window of the <a href=\"/docs/issuing/controls/real-time-authorizations\">real-time authorization</a> flow. \nThis method is deprecated. Instead, <a href=\"/docs/issuing/controls/real-time-authorizations#authorization-handling\">respond directly to the webhook request to approve an authorization</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/authorizations/{authorization}/approve`\n"
    (
      @spec approve(
              authorization :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def approve(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}/approve",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>[Deprecated] Declines a pending Issuing <code>Authorization</code> object. This request should be made within the timeout window of the <a href=\"/docs/issuing/controls/real-time-authorizations\">real time authorization</a> flow.\nThis method is deprecated. Instead, <a href=\"/docs/issuing/controls/real-time-authorizations#authorization-handling\">respond directly to the webhook request to decline an authorization</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/authorizations/{authorization}/decline`\n"
    (
      @spec decline(
              authorization :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def decline(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/authorizations/{authorization}/decline",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Create a test-mode authorization.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/authorizations`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:amount_details) => amount_details,
                optional(:authorization_method) =>
                  :chip | :contactless | :keyed_in | :online | :swipe,
                optional(:card) => binary,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:is_amount_controllable) => boolean,
                optional(:merchant_data) => merchant_data,
                optional(:network_data) => network_data,
                optional(:verification_data) => verification_data,
                optional(:wallet) => :apple_pay | :google_pay | :samsung_pay
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/authorizations",
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

    @doc "<p>Increment a test-mode Authorization.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/authorizations/{authorization}/increment`\n"
    (
      @spec increment(
              authorization :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:increment_amount) => integer,
                optional(:is_amount_controllable) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def increment(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/authorizations/{authorization}/increment",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Reverse a test-mode Authorization.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/authorizations/{authorization}/reverse`\n"
    (
      @spec reverse(
              authorization :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:reverse_amount) => integer},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def reverse(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/authorizations/{authorization}/reverse",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Expire a test-mode Authorization.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/authorizations/{authorization}/expire`\n"
    (
      @spec expire(
              authorization :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def expire(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/authorizations/{authorization}/expire",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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

    @doc "<p>Capture a test-mode authorization.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/authorizations/{authorization}/capture`\n"
    (
      @spec capture(
              authorization :: binary(),
              params :: %{
                optional(:capture_amount) => integer,
                optional(:close_authorization) => boolean,
                optional(:expand) => list(binary),
                optional(:purchase_details) => purchase_details
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.Authorization.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def capture(authorization, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/authorizations/{authorization}/capture",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "authorization",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "authorization",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [authorization]
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
