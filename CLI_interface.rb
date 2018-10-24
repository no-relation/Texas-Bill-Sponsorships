require_relative 'config/environment.rb'

$prompt = TTY::Prompt.new

# * User is prompted for what they want:
def welcome_explainer
    puts "Texas Legislature Bill Sponsor Explorer Revealer Explainer"
    puts "(from Open States API v1)"
end

def user_prompt
    puts "What would you like to know?"
end

def choice_list_legislators
    choices = {}
    Legislator.all_but_lt_gov.each do |lege|
        party = nil
        if lege.party == "Democratic"
            party = "(D)"
        elsif lege.party == "Republican"
            party = "(R)"
        end

        name_and_party = "#{lege.full_name} #{party}"
        # add 'legislator name' => 'legislator id' keyvalue pair to choices
        choices[name_and_party] = lege.id
    end
    choices
end

def choice_list_bills
    choices = {}
    Bill.all.each do |bill|
        # truncating bill title
        title_array = bill.title.split
        if title_array.length < 15
            truncated_title = title_array.join(" ")
        else
            truncated_title = "#{title_array[0..15].join(" ")}..."
        end
        # 'bill lege id':'bill title (truncated)' => 'bill index id' to choices
        # e.g. 'HB 21: Relating to public school...' => 1
        choices["#{bill.lege_id}: #{truncated_title}"] = bill.id
    end
    choices
end
#         * "Legislator with the most/least..."

#         * "Bill with the most/least..."

choices = {Legislator.all.third.full_name => Legislator.all.third.id, Legislator.all.fourth.full_name => Legislator.all.fourth.id}
result = user_prompt
binding.pry
0
#         * breakdown of:
#             * legislator's bills
#             * whether they're the primary or cosponsor
#             * the subjects of those bills
#         * breakdown of;
#             * bill's sponsors
#             * most partisan or bipartisan
#             * a bill's subjects
#             * bill with the most subjects
#             * bills by subject
#             * subject that appears in the most bills