global class JSON2ApexORGNew 
{

    global class Sub_organizations
    {
        global Paging paging{get;set;}
        global List<Items_Y> items{get;set;}
    }

    global class News {
        global Paging paging{get;set;}
        global List<Items_Q> items{get;set;}
    }

    global class Categories {
        global Paging paging{get;set;}
        global List<Items_U> items{get;set;}
    }

    global class Funding_round {
        global String path{get;set;}
    }

    global class Properties {
        global Boolean role_company{get;set;}
        global String permalink{get;set;}
        global String primary_role{get;set;}
        global Boolean is_closed{get;set;}
        global Integer closed_on_trust_code{get;set;}
        global String name{get;set;}
        global String short_description{get;set;}
        global String description{get;set;}
        global String homepage_url{get;set;}
        global Object closed_on_year{get;set;}
        global Object closed_on_day{get;set;}
        global Object closed_on_month{get;set;}
        global Object closed_on{get;set;}
        global Integer founded_on_day{get;set;}
        global Integer founded_on_month{get;set;}
        global Integer founded_on_year{get;set;}
        global String founded_on{get;set;}
        global Integer founded_on_trust_code{get;set;}
        global String email_address{get;set;}
        global Boolean secondary_role_for_profit{get;set;}
        global Integer num_employees_max{get;set;}
        global Integer num_employees_min{get;set;}
        global Boolean role_investor{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
        global Integer total_funding_usd{get;set;}
        global Integer number_of_investments{get;set;}
        global String stock_symbol{get;set;}
        global Integer number_of_employees{get;set;}
    }

    global class Data {
        global String uuid{get;set;}
        global String type{get;set;}
        global Properties properties{get;set;}
        global Relationships relationships{get;set;}
    }

    global class Items_Q {
        global String url{get;set;}
        global Object author{get;set;}
        global String posted_on{get;set;}
        global String type{get;set;}
        global String title{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Items_R {
        global String url{get;set;}
        global String type{get;set;}
        global String title{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Paging {
        global Integer total_items{get;set;}
        global String first_page_url{get;set;}
        global String sort_order{get;set;}
    }

    global class Items_S {
        global String type{get;set;}
        global Object title{get;set;}
        global String path{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Items_T {
        global String type{get;set;}
        global Object money_invested{get;set;}
        global String money_invested_currency_code{get;set;}
        global Object money_invested_usd{get;set;}
        global Funding_round funding_round{get;set;}
        global Invested_in invested_in{get;set;}
    }

    global class Items_U {
        global String type{get;set;}
        global String name{get;set;}
        global String uuid{get;set;}
        global String path{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Items_V {
        global String type{get;set;}
        global String name{get;set;}
        global String street_1{get;set;}
        global Object street_2{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
        global String city{get;set;}
        global String city_uuid{get;set;}
        global String city_path{get;set;}
        global String region{get;set;}
        global String country_code{get;set;}
    }

    global class Items_W {
        global String type{get;set;}
        global String name{get;set;}
        global String street_1{get;set;}
        global String street_2{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
        global String city{get;set;}
        global String city_uuid{get;set;}
        global String city_path{get;set;}
        global String region{get;set;}
        global String country_code{get;set;}
    }

    global class Items_X {
        global String announced_on{get;set;}
        global String type{get;set;}
        global String name{get;set;}
        global String path{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Past_team {
        global Paging paging{get;set;}
        global List<Items> items{get;set;}
    }

    global class Items_Y {
        global String type{get;set;}
        global String name{get;set;}
        global String path{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Items_Z {
        global String first_name{get;set;}
        global String last_name{get;set;}
        global String title{get;set;}
        global Object started_on{get;set;}
        global String path{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Relationships {
        global Past_team past_team{get;set;}
        global Board_members_and_advisors board_members_and_advisors{get;set;}
        global Sub_organizations sub_organizations{get;set;}
        global Board_members_and_advisors current_team{get;set;}
        global Acquisitions acquisitions{get;set;}
        global Sub_organizations competitors{get;set;}
        global Offices offices{get;set;}
        global Headquarters headquarters{get;set;}
        global Sub_organizations funding_rounds{get;set;}
        global Categories categories{get;set;}
        global Sub_organizations members{get;set;}
        global Sub_organizations customers{get;set;}
        global Investments investments{get;set;}
        global Sub_organizations founders{get;set;}
        global Sub_organizations ipo{get;set;}
        global Sub_organizations products{get;set;}
        global Primary_image primary_image{get;set;}
        global Primary_image images{get;set;}
        global Websites websites{get;set;}
        global News news{get;set;}
    }

    global class Invested_in {
        global String type{get;set;}
        global String name{get;set;}
        global String path{get;set;}
    }

    global class Items {
        global String first_name{get;set;}
        global String last_name{get;set;}
        global String title{get;set;}
        global String started_on{get;set;}
        global String ended_on{get;set;}
        global String path{get;set;}
        global Integer created_at{get;set;}
        global Integer updated_at{get;set;}
    }

    global class Investments {
        global Paging paging{get;set;}
        global List<Items_T> items{get;set;}
    }

    global class Acquisitions {
        global Paging paging{get;set;}
        global List<Items_X> items{get;set;}
    }

    global class Headquarters {
        global Paging paging{get;set;}
        global List<Items_V> items{get;set;}
    }

    global class Offices {
        global Paging paging{get;set;}
        global List<Items_W> items{get;set;}
    }

    global class Websites {
        global Paging paging{get;set;}
        global List<Items_R> items{get;set;}
    }

    global Metadata metadata{get;set;}
    global Data data{get;set;}

    global class Primary_image {
        global Paging paging{get;set;}
        global List<Items_S> items{get;set;}
    }

    global class Metadata {
        global Integer version{get;set;}
        global String www_path_prefix{get;set;}
        global String api_path_prefix{get;set;}
        global String image_path_prefix{get;set;}
    }

    global class Board_members_and_advisors {
        global Paging paging{get;set;}
        global List<Items_Z> items{get;set;}
    }

    
    global static JSON2ApexORGNew parse(String json) {
        return (JSON2ApexORGNew) System.JSON.deserialize(json,JSON2ApexORGNew.class);
    }
    }