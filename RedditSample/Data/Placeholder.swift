//
//  Placeholder.swift
//  RedditSample
//
//  This file only serves to hold fake temporary data that mimics what it would receive
//  from the network.
//
//  Created by Danny Gilbert on 11/22/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation

typealias RedditListing = (title: String, link: String)

protocol PlaceholderDataContainer {
    var container: DataContainer { get set }
}

class DataContainer {
    var data: [RedditConstants.Categories: [RedditListing]] = [
        .top: [
            RedditListing(
                title: "I wrote our U.S Rep. Roger Williams several months ago and received a reply today.",
                link: "https://www.reddit.com/r/Austin/comments/7ejw2t/i_wrote_our_us_rep_roger_williams_several_months/"
            ),
            RedditListing(
                title: "Lamar Smith Automated Reply Against Net Neutrality",
                link: "https://www.reddit.com/r/Austin/comments/7emo1p/lamar_smith_automated_reply_against_net_neutrality/"
            ),
            RedditListing(
                title: "Play games by Texans, for Texans, with Texans. Texas.",
                link: "https://www.reddit.com/r/Austin/comments/7ekn0w/play_games_by_texans_for_texans_with_texans_texas/"
            ),
            RedditListing(
                title: "The VERTS change is going well",
                link: "https://www.reddit.com/r/Austin/comments/7elqot/the_verts_change_is_going_well/"
            ),
            RedditListing(
                title: "City waiving parking tickets for people who choose not to drive drunk",
                link: "https://www.reddit.com/r/Austin/comments/7ekxqg/city_waiving_parking_tickets_for_people_who/"
            ),
            RedditListing(
                title: "UT student who said “I’m a UT student! You can’t arrest me!” after crashing into a restaurant on Guad is identified (Esther Shim)",
                link: "https://www.reddit.com/r/Austin/comments/7elu5m/ut_student_who_said_im_a_ut_student_you_cant/"
            )
        ],
        .hot: [
            RedditListing(
                title: "Lets use our power to do what we can to \"battle for the net\"",
                link: "https://www.reddit.com/r/Austin/comments/7eo7p2/lets_use_our_power_to_do_what_we_can_to_battle/"
            ),
            RedditListing(
                title: "Austin: Drunkest city in Texas!",
                link: "https://www.reddit.com/r/Austin/comments/7em0zk/austin_drunkest_city_in_texas/"
            ),
            RedditListing(
                title: "Castle Hill graffiti park moving to 6-acres on Carson Creek Ranch",
                link: "https://www.reddit.com/r/Austin/comments/7eju8o/castle_hill_graffiti_park_moving_to_6acres_on/"
            ),
            RedditListing(
                title: "Last year there was a list on Reddit of all of the local establishments open on Thanksgiving. I can’t seem to find this year’s list—has one been made?",
                link: "https://www.reddit.com/r/Austin/comments/7em077/last_year_there_was_a_list_on_reddit_of_all_of/"
            ),
            RedditListing(
                title: "Woman uses children to shoplift at Macy’s at The Domain",
                link: "https://www.reddit.com/r/Austin/comments/7els55/woman_uses_children_to_shoplift_at_macys_at_the/"
            )
        ],
        .new: [
            RedditListing(
                title: "This is how much more money you'll need for a down payment in Austin in 2018",
                link: "https://www.reddit.com/r/Austin/comments/7ejcl5/this_is_how_much_more_money_youll_need_for_a_down/"
            ),
            RedditListing(
                title: "APD contract heads for City Council after union approval",
                link: "https://www.reddit.com/r/Austin/comments/7ej32r/apd_contract_heads_for_city_council_after_union/"
            ),
            RedditListing(
                title: "does anyone have information on the legal outcome of this fight on 6th street in 2016?",
                link: "https://www.reddit.com/r/Austin/comments/7egz7w/does_anyone_have_information_on_the_legal_outcome/"
            ),
            RedditListing(
                title: "Anyone interested in a Verizon protest in Austin? Will host.",
                link: "https://www.reddit.com/r/Austin/comments/7enucb/anyone_interested_in_a_verizon_protest_in_austin/"
            ),
            RedditListing(
                title: "Spectrum internet",
                link: "https://www.reddit.com/r/Austin/comments/7efscu/spectrum_internet/"
            ),
            RedditListing(
                title: "Peanut-free bakery suggestion",
                link: "https://www.reddit.com/r/Austin/comments/7eige7/peanutfree_bakery_suggestion/"
            )
        ],
        .controversial: [
            RedditListing(
                title: "What can we do to fight the FCC???",
                link: "https://www.reddit.com/r/Austin/comments/7enek8/what_can_we_do_to_fight_the_fcc/"
            ),
            RedditListing(
                title: "Two more women accuse guard of sexual misconduct at immigration lockup",
                link: "https://www.reddit.com/r/Austin/comments/7eo9s4/two_more_women_accuse_guard_of_sexual_misconduct/"
            ),
            RedditListing(
                title: "Man shot and critically wounded in north Austin neighborhood",
                link: "https://www.reddit.com/r/Austin/comments/7elf36/man_shot_and_critically_wounded_in_north_austin/"
            ),
            RedditListing(
                title: "Looking for a toys for tots/clothes drive charity to donate to",
                link: "https://www.reddit.com/r/Austin/comments/7ejz0p/looking_for_a_toys_for_totsclothes_drive_charity/"
            ),
            RedditListing(
                title: "Remember that Terrence Malick film that was being filmed around town for forever like 3-4 years ago? Well here it is in all of its nonsensical, college arthouse, Austin masturbatory glory!",
                link: "https://www.reddit.com/r/Austin/comments/7eiqcn/remember_that_terrence_malick_film_that_was_being/"
            )
        ],
        .rising: [
            RedditListing(
                title: "Has anyone bought a house from Priority Texas Homes?",
                link: "https://www.reddit.com/r/Austin/comments/7el922/has_anyone_bought_a_house_from_priority_texas/"
            ),
            RedditListing(
                title: "Substitute Teaching in Austin?",
                link: "https://www.reddit.com/r/Austin/comments/7eogc3/substitute_teaching_in_austin/"
            ),
            RedditListing(
                title: "Anyone watching the MLS playoffs tonight? Where??",
                link: "https://www.reddit.com/r/Austin/comments/7eiw3p/anyone_watching_the_mls_playoffs_tonight_where/"
            )
        ]
    ]
}
