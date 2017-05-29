global class OrganizationJSONApex {
    global static void consumeObject(JSONParser parser) {
        Integer depth = 0;
        do {
            JSONToken curr = parser.getCurrentToken();
            if (curr == JSONToken.START_OBJECT || 
                curr == JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == JSONToken.END_OBJECT ||
                curr == JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }

    global class Sub_organizations {
        global Paging paging {get;set;}
        global List<Items_Y> items {get;set;}

        global  Sub_organizations(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_Y>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_Y(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Sub_organizations consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class News {
        global  Paging paging {get;set;}
        global  List<Items_Q> items {get;set;}

        global  News(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_Q>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_Q(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'News consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Categories {
        global  Paging paging {get;set;}
        global  List<Items_U> items {get;set;}

        global  Categories(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_U>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_U(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Categories consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Funding_round {
        global  String path {get;set;}

        global  Funding_round(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'path') {
                            path = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Funding_round consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Properties {
        global  Boolean role_company {get;set;}
        global  String email_address {get;set;}
        global  String description {get;set;}
        global  String short_description {get;set;}
        global  Integer founded_on_day {get;set;}
        global  Integer founded_on_month {get;set;}
        global  Integer founded_on_year {get;set;}
        global  String founded_on {get;set;}
        global  Integer founded_on_trust_code {get;set;}
        global  String permalink {get;set;}
        global  String primary_role {get;set;}
        global  Integer closed_on_trust_code {get;set;}
        global  String homepage_url {get;set;}
        global  String name {get;set;}
        global  Boolean is_closed {get;set;}
        global  Integer num_employees_max {get;set;}
        global  Integer num_employees_min {get;set;}
        global  Boolean secondary_role_for_profit {get;set;}
        global  Object closed_on_day {get;set;}
        global  Object closed_on_month {get;set;}
        global  Object closed_on_year {get;set;}
        global  Object closed_on {get;set;}
        global  Boolean role_investor {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}
        global  Integer total_funding_usd {get;set;}
        global  Integer number_of_investments {get;set;}
        global  String stock_symbol {get;set;}
        global  Integer number_of_employees {get;set;}

        global  Properties(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'role_company') {
                            role_company = parser.getBooleanValue();
                        } else if (text == 'email_address') {
                            email_address = parser.getText();
                        } else if (text == 'description') {
                            description = parser.getText();
                        } else if (text == 'short_description') {
                            short_description = parser.getText();
                        } else if (text == 'founded_on_day') {
                            founded_on_day = parser.getIntegerValue();
                        } else if (text == 'founded_on_month') {
                            founded_on_month = parser.getIntegerValue();
                        } else if (text == 'founded_on_year') {
                            founded_on_year = parser.getIntegerValue();
                        } else if (text == 'founded_on') {
                            founded_on = parser.getText();
                        } else if (text == 'founded_on_trust_code') {
                            founded_on_trust_code = parser.getIntegerValue();
                        } else if (text == 'permalink') {
                            permalink = parser.getText();
                        } else if (text == 'primary_role') {
                            primary_role = parser.getText();
                        } else if (text == 'closed_on_trust_code') {
                            closed_on_trust_code = parser.getIntegerValue();
                        } else if (text == 'homepage_url') {
                            homepage_url = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'is_closed') {
                            is_closed = parser.getBooleanValue();
                        } else if (text == 'num_employees_max') {
                            num_employees_max = parser.getIntegerValue();
                        } else if (text == 'num_employees_min') {
                            num_employees_min = parser.getIntegerValue();
                        } else if (text == 'secondary_role_for_profit') {
                            secondary_role_for_profit = parser.getBooleanValue();
                        }  else if (text == 'role_investor') {
                            role_investor = parser.getBooleanValue();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else if (text == 'total_funding_usd') {
                            total_funding_usd = parser.getIntegerValue();
                        } else if (text == 'number_of_investments') {
                            number_of_investments = parser.getIntegerValue();
                        } else if (text == 'stock_symbol') {
                            stock_symbol = parser.getText();
                        } else if (text == 'number_of_employees') {
                            number_of_employees = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Properties consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Data {
        global  String uuid {get;set;}
        global  String type {get;set;}
        global  Properties properties {get;set;}
        global  Relationships relationships {get;set;}

        global  Data(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'uuid') {
                            uuid = parser.getText();
                        } else if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'properties') {
                            properties = new Properties(parser);
                        } else if (text == 'relationships') {
                            relationships = new Relationships(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_Q {
        global  String url {get;set;}
        global  Object author {get;set;}
        global  String posted_on {get;set;}
        global  String type {get;set;}
        global  String title {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_Q(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'url') {
                            url = parser.getText();
                        } else if (text == 'posted_on') {
                            posted_on = parser.getText();
                        } else if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'title') {
                            title = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_Q consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_R {
        global  String url {get;set;}
        global  String type {get;set;}
        global  String title {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_R(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'url') {
                            url = parser.getText();
                        } else if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'title') {
                            title = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_R consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Paging {
        global  Integer total_items {get;set;}
        global  String first_page_url {get;set;}
        global  String sort_order {get;set;}

        global  Paging(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'total_items') {
                            total_items = parser.getIntegerValue();
                        } else if (text == 'first_page_url') {
                            first_page_url = parser.getText();
                        } else if (text == 'sort_order') {
                            sort_order = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Paging consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_S {
        global  String type {get;set;}
        global  Object title {get;set;}
        global  String path {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_S(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        }  else if (text == 'path') {
                            path = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_S consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_T {
        global  String type {get;set;}
        global  Object money_invested {get;set;}
        global  String money_invested_currency_code {get;set;}
        global  Object money_invested_usd {get;set;}
        global  Funding_round funding_round {get;set;}
        global  Invested_in invested_in {get;set;}

        global  Items_T(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        }  else if (text == 'money_invested_currency_code') {
                            money_invested_currency_code = parser.getText();
                        }  else if (text == 'funding_round') {
                            funding_round = new Funding_round(parser);
                        } else if (text == 'invested_in') {
                            invested_in = new Invested_in(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_T consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_U {
        global  String type {get;set;}
        global  String name {get;set;}
        global  String uuid {get;set;}
        global  String path {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_U(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'uuid') {
                            uuid = parser.getText();
                        } else if (text == 'path') {
                            path = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_U consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_V {
        global  String type {get;set;}
        global  String name {get;set;}
        global  String street_1 {get;set;}
        global  Object street_2 {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}
        global  String city {get;set;}
        global  String city_uuid {get;set;}
        global  String city_path {get;set;}
        global  String region {get;set;}
        global  String country_code {get;set;}

        global  Items_V(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'street_1') {
                            street_1 = parser.getText();
                        }  else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else if (text == 'city') {
                            city = parser.getText();
                        } else if (text == 'city_uuid') {
                            city_uuid = parser.getText();
                        } else if (text == 'city_path') {
                            city_path = parser.getText();
                        } else if (text == 'region') {
                            region = parser.getText();
                        } else if (text == 'country_code') {
                            country_code = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_V consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_W {
        global  String type {get;set;}
        global  String name {get;set;}
        global  String street_1 {get;set;}
        global  String street_2 {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}
        global  String city {get;set;}
        global  String city_uuid {get;set;}
        global  String city_path {get;set;}
        global  String region {get;set;}
        global  String country_code {get;set;}

        global  Items_W(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'street_1') {
                            street_1 = parser.getText();
                        } else if (text == 'street_2') {
                            street_2 = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else if (text == 'city') {
                            city = parser.getText();
                        } else if (text == 'city_uuid') {
                            city_uuid = parser.getText();
                        } else if (text == 'city_path') {
                            city_path = parser.getText();
                        } else if (text == 'region') {
                            region = parser.getText();
                        } else if (text == 'country_code') {
                            country_code = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_W consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_X {
        global  String announced_on {get;set;}
        global  String type {get;set;}
        global  String name {get;set;}
        global  String path {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_X(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'announced_on') {
                            announced_on = parser.getText();
                        } else if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'path') {
                            path = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_X consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Past_team {
        global  Paging paging {get;set;}
        global  List<Items> items {get;set;}

        global  Past_team(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Past_team consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_Y {
        global  String type {get;set;}
        global  String name {get;set;}
        global  String path {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_Y(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'path') {
                            path = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_Y consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items_Z {
        global  String first_name {get;set;}
        global  String last_name {get;set;}
        global  String title {get;set;}
        global  Object started_on {get;set;}
        global  String path {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items_Z(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'first_name') {
                            first_name = parser.getText();
                        } else if (text == 'last_name') {
                            last_name = parser.getText();
                        } else if (text == 'title') {
                            title = parser.getText();
                        } else if (text == 'path') {
                            path = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items_Z consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Relationships {
        global  Past_team past_team {get;set;}
        global  Board_members_and_advisors board_members_and_advisors {get;set;}
        global  Sub_organizations sub_organizations {get;set;}
        global  Board_members_and_advisors current_team {get;set;}
        global  Acquisitions acquisitions {get;set;}
        global  Sub_organizations competitors {get;set;}
        global  Offices offices {get;set;}
        global  Headquarters headquarters {get;set;}
        global  Sub_organizations funding_rounds {get;set;}
        global  Categories categories {get;set;}
        global  Sub_organizations members {get;set;}
        global  Sub_organizations customers {get;set;}
        global  Investments investments {get;set;}
        global  Sub_organizations founders {get;set;}
        global  Sub_organizations ipo {get;set;}
        global  Sub_organizations products {get;set;}
        global  Primary_image primary_image {get;set;}
        global  Primary_image images {get;set;}
        global  Websites websites {get;set;}
        global  News news {get;set;}

        global  Relationships(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'past_team') {
                            past_team = new Past_team(parser);
                        } else if (text == 'board_members_and_advisors') {
                            board_members_and_advisors = new Board_members_and_advisors(parser);
                        } else if (text == 'sub_organizations') {
                            sub_organizations = new Sub_organizations(parser);
                        } else if (text == 'current_team') {
                            current_team = new Board_members_and_advisors(parser);
                        } else if (text == 'acquisitions') {
                            acquisitions = new Acquisitions(parser);
                        } else if (text == 'competitors') {
                            competitors = new Sub_organizations(parser);
                        } else if (text == 'offices') {
                            offices = new Offices(parser);
                        } else if (text == 'headquarters') {
                            headquarters = new Headquarters(parser);
                        } else if (text == 'funding_rounds') {
                            funding_rounds = new Sub_organizations(parser);
                        } else if (text == 'categories') {
                            categories = new Categories(parser);
                        } else if (text == 'members') {
                            members = new Sub_organizations(parser);
                        } else if (text == 'customers') {
                            customers = new Sub_organizations(parser);
                        } else if (text == 'investments') {
                            investments = new Investments(parser);
                        } else if (text == 'founders') {
                            founders = new Sub_organizations(parser);
                        } else if (text == 'ipo') {
                            ipo = new Sub_organizations(parser);
                        } else if (text == 'products') {
                            products = new Sub_organizations(parser);
                        } else if (text == 'primary_image') {
                            primary_image = new Primary_image(parser);
                        } else if (text == 'images') {
                            images = new Primary_image(parser);
                        } else if (text == 'websites') {
                            websites = new Websites(parser);
                        } else if (text == 'news') {
                            news = new News(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Relationships consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Invested_in {
        global  String type {get;set;}
        global  String name {get;set;}
        global  String path {get;set;}

        global  Invested_in(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'path') {
                            path = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Invested_in consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Items {
        global  String first_name {get;set;}
        global  String last_name {get;set;}
        global  String title {get;set;}
        global  String started_on {get;set;}
        global  String ended_on {get;set;}
        global  String path {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}

        global  Items(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'first_name') {
                            first_name = parser.getText();
                        } else if (text == 'last_name') {
                            last_name = parser.getText();
                        } else if (text == 'title') {
                            title = parser.getText();
                        } else if (text == 'started_on') {
                            started_on = parser.getText();
                        } else if (text == 'ended_on') {
                            ended_on = parser.getText();
                        } else if (text == 'path') {
                            path = parser.getText();
                        } else if (text == 'created_at') {
                            created_at = parser.getIntegerValue();
                        } else if (text == 'updated_at') {
                            updated_at = parser.getIntegerValue();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Items consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Investments {
        global  Paging paging {get;set;}
        global  List<Items_T> items {get;set;}

        global  Investments(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_T>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_T(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Investments consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Acquisitions {
        global  Paging paging {get;set;}
        global  List<Items_X> items {get;set;}

        global  Acquisitions(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_X>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_X(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Acquisitions consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Headquarters {
        global  Paging paging {get;set;}
        global  List<Items_V> items {get;set;}

        global  Headquarters(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_V>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_V(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Headquarters consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Offices {
        global  Paging paging {get;set;}
        global  List<Items_W> items {get;set;}

        global  Offices(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_W>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_W(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Offices consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Websites {
        global  Paging paging {get;set;}
        global  List<Items_R> items {get;set;}

        global  Websites(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_R>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_R(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Websites consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  Metadata metadata {get;set;}
    global  Data data {get;set;}

    global  OrganizationJSONApex(JSONParser parser) {
        while (parser.nextToken() != JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != JSONToken.VALUE_NULL) {
                    if (text == 'metadata') {
                        metadata = new Metadata(parser);
                    } else if (text == 'data') {
                        data = new Data(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'Root consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    global  class Primary_image {
        global  Paging paging {get;set;}
        global  List<Items_S> items {get;set;}

        global  Primary_image(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_S>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_S(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Primary_image consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Metadata {
        global  Integer version {get;set;}
        global  String www_path_prefix {get;set;}
        global  String api_path_prefix {get;set;}
        global  String image_path_prefix {get;set;}

        global  Metadata(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'version') {
                            version = parser.getIntegerValue();
                        } else if (text == 'www_path_prefix') {
                            www_path_prefix = parser.getText();
                        } else if (text == 'api_path_prefix') {
                            api_path_prefix = parser.getText();
                        } else if (text == 'image_path_prefix') {
                            image_path_prefix = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Metadata consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    global  class Board_members_and_advisors {
        global  Paging paging {get;set;}
        global  List<Items_Z> items {get;set;}

        global  Board_members_and_advisors(JSONParser parser) {
            while (parser.nextToken() != JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) {
                        if (text == 'paging') {
                            paging = new Paging(parser);
                        } else if (text == 'items') {
                            items = new List<Items_Z>();
                            while (parser.nextToken() != JSONToken.END_ARRAY) {
                                items.add(new Items_Z(parser));
                            }
                        } else {
                            System.debug(LoggingLevel.WARN, 'Board_members_and_advisors consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    
    global  static OrganizationJSONApex parse(String json) {
        return new OrganizationJSONApex(System.JSON.createParser(json));
    }
    
      
    }