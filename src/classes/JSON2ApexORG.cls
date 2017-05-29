global class JSON2ApexORG {

    global class Sub_organizations {
        global Paging paging;
        global List<Items_Y> items;
    }

    global class News {
        global Paging paging;
        global List<Items_Q> items;
    }

    global class Categories {
        global Paging paging;
        global List<Items_U> items;
    }

    global class Funding_round {
        global String path;
    }

    global class Properties {
        global Boolean role_company;
        global String email_address;
        global String description;
        global String short_description;
        global Integer founded_on_day;
        global Integer founded_on_month;
        global Integer founded_on_year;
        global String founded_on;
        global Integer founded_on_trust_code;
        global String permalink;
        global String primary_role;
        global Integer closed_on_trust_code;
        global String homepage_url;
        global String name;
        global Boolean is_closed;
        global Integer num_employees_max;
        global Integer num_employees_min;
        global Boolean secondary_role_for_profit;
        global Object closed_on_day;
        global Object closed_on_month;
        global Object closed_on_year;
        global Object closed_on;
        global Boolean role_investor;
        global Integer created_at;
        global Integer updated_at;
        global Integer total_funding_usd;
        global Integer number_of_investments;
        global String stock_symbol;
        global Integer number_of_employees;
    }

    global class Data {
        global String uuid;
        global String type;
        global Properties properties;
        global Relationships relationships;
    }

    global class Items_Q {
        global String url;
        global Object author;
        global String posted_on;
        global String type;
        global String title;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Items_R {
        global String url;
        global String type;
        global String title;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Paging {
        global Integer total_items;
        global String first_page_url;
        global String sort_order;
    }

    global class Items_S {
        global String type;
        global Object title;
        global String path;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Items_T {
        global String type;
        global Object money_invested;
        global String money_invested_currency_code;
        global Object money_invested_usd;
        global Funding_round funding_round;
        global Invested_in invested_in;
    }

    global class Items_U {
        global String type;
        global String name;
        global String uuid;
        global String path;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Items_V {
        global String type;
        global String name;
        global String street_1;
        global Object street_2;
        global Integer created_at;
        global Integer updated_at;
        global String city;
        global String city_uuid;
        global String city_path;
        global String region;
        global String country_code;
    }

    global class Items_W {
        global String type;
        global String name;
        global String street_1;
        global String street_2;
        global Integer created_at;
        global Integer updated_at;
        global String city;
        global String city_uuid;
        global String city_path;
        global String region;
        global String country_code;
    }

    global class Items_X {
        global String announced_on;
        global String type;
        global String name;
        global String path;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Past_team {
        global Paging paging;
        global List<Items> items;
    }

    global class Items_Y {
        global String type;
        global String name;
        global String path;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Items_Z {
        global String first_name;
        global String last_name;
        global String title;
        global Object started_on;
        global String path;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Relationships {
        global Past_team past_team;
        global Board_members_and_advisors board_members_and_advisors;
        global Sub_organizations sub_organizations;
        global Board_members_and_advisors current_team;
        global Acquisitions acquisitions;
        global Sub_organizations competitors;
        global Offices offices;
        global Headquarters headquarters;
        global Sub_organizations funding_rounds;
        global Categories categories;
        global Sub_organizations members;
        global Sub_organizations customers;
        global Investments investments;
        global Sub_organizations founders;
        global Sub_organizations ipo;
        global Sub_organizations products;
        global Primary_image primary_image;
        global Primary_image images;
        global Websites websites;
        global News news;
    }

    global class Invested_in {
        global String type;
        global String name;
        global String path;
    }

    global class Items {
        global String first_name;
        global String last_name;
        global String title;
        global String started_on;
        global String ended_on;
        global String path;
        global Integer created_at;
        global Integer updated_at;
    }

    global class Investments {
        global Paging paging;
        global List<Items_T> items;
    }

    global class Acquisitions {
        global Paging paging;
        global List<Items_X> items;
    }

    global class Headquarters {
        global Paging paging;
        global List<Items_V> items;
    }

    global class Offices {
        global Paging paging;
        global List<Items_W> items;
    }

    global class Websites {
        global Paging paging;
        global List<Items_R> items;
    }

    global Data data;

    global class Primary_image {
        global Paging paging;
        global List<Items_S> items;
    }

    global class Board_members_and_advisors {
        global Paging paging;
        global List<Items_Z> items;
    }

    
    global static JSON2ApexORG parse(String json) {
        return (JSON2ApexORG) System.JSON.deserialize(json, JSON2ApexORG.class);
    }
    }