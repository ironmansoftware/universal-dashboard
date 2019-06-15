---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version:https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDButton.md
schema: 2.0.0
---

# New-UDButton

## SYNOPSIS
Creates a new button.

## SYNTAX

```
New-UDButton [[-Id] <String>] [[-Text] <Object>] [[-OnClick] <Object>] [-Floating] [-Flat]
 [[-Icon] <FontAwesomeIcons>] [[-IconAlignment] <String>] [[-BackgroundColor] <DashboardColor>]
 [[-FontColor] <DashboardColor>] [-Disabled] [<CommonParameters>]
```

## DESCRIPTION
Creates a new button. Buttons come in different shapes and sizes and can be configured to execute scripts when clicked. 

## EXAMPLES

### Raised Button
```powershell
New-UDButton -Text "Button" 
```

Creates a basic, raised button.

### Button with Icon
```powershell
New-UDButton -Text "Button" -Icon cloud
```

Creates a basic, raised button with an icon.

### Button Colors
```powershell
New-UDButton -Text "Button" -BackgroundColor "red" -FontColor "white"
```

Creates a red button with white text.

### Floating
```powershell
New-UDButton -Floating -Icon plus
```

Creates a circular, floating button with a plus icon.

### Floating
```powershell
New-UDButton -Flat -Text "Button"
```

Creates a flat button

### OnClick Event Handler
```powershell
New-UDButton -Text "Button" -OnClick {
    Show-UDToast -Message "Ouch!"
}
```

Creats a button that shows a toast message when clicked. 


## PARAMETERS

### -BackgroundColor
Background color of the button.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disabled
Creates a disabled button.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Flat
Creates a flat button without shadows. 

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Floating
Creates a circular, floating button.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
Font color of the button. This also changes the icon color.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
The icon for this button.

```yaml
Type: FontAwesomeIcons
Parameter Sets: (All)
Aliases:
Accepted values: None, ad, address_book, address_card, adjust, air_freshener, align_center, align_justify, align_left, align_right, allergies, ambulance, american_sign_language_interpreting, anchor, angle_double_down, angle_double_left, angle_double_right, angle_double_up, angle_down, angle_left, angle_right, angle_up, angry, ankh, apple_alt, archive, archway, arrow_alt_circle_down, arrow_alt_circle_left, arrow_alt_circle_right, arrow_alt_circle_up, arrow_circle_down, arrow_circle_left, arrow_circle_right, arrow_circle_up, arrow_down, arrow_left, arrow_right, arrows_alt, arrows_alt_h, arrows_alt_v, arrow_up, assistive_listening_systems, asterisk, at, atlas, atom, audio_description, award, baby, baby_carriage, backspace, backward, balance_scale, ban, band_aid, barcode, bars, baseball_ball, basketball_ball, bath, battery_empty, battery_full, battery_half, battery_quarter, battery_three_quarters, bed, beer, bell, bell_slash, bezier_curve, bible, bicycle, binoculars, biohazard, birthday_cake, blender, blender_phone, blind, blog, bold, bolt, bomb, bone, bong, book, book_dead, bookmark, book_open, book_reader, bowling_ball, box, boxes, box_open, braille, brain, briefcase, briefcase_medical, broadcast_tower, broom, brush, bug, building, bullhorn, bullseye, burn, bus, bus_alt, business_time, calculator, calendar, calendar_alt, calendar_check, calendar_day, calendar_minus, calendar_plus, calendar_times, calendar_week, camera, camera_retro, campground, candy_cane, cannabis, capsules, car, car_alt, car_battery, car_crash, caret_down, caret_left, caret_right, caret_square_down, caret_square_left, caret_square_right, caret_square_up, caret_up, carrot, car_side, cart_arrow_down, cart_plus, cash_register, cat, certificate, chair, chalkboard, chalkboard_teacher, charging_station, chart_area, chart_bar, chart_line, chart_pie, check, check_circle, check_double, check_square, chess, chess_bishop, chess_board, chess_king, chess_knight, chess_pawn, chess_queen, chess_rook, chevron_circle_down, chevron_circle_left, chevron_circle_right, chevron_circle_up, chevron_down, chevron_left, chevron_right, chevron_up, child, church, circle, circle_notch, city, clipboard, clipboard_check, clipboard_list, clock, clone, closed_captioning, cloud, cloud_download_alt, cloud_meatball, cloud_moon, cloud_moon_rain, cloud_rain, cloud_showers_heavy, cloud_sun, cloud_sun_rain, cloud_upload_alt, cocktail, code, code_branch, coffee, cog, cogs, coins, columns, comment, comment_alt, comment_dollar, comment_dots, comments, comments_dollar, comment_slash, compact_disc, compass, compress, compress_arrows_alt, concierge_bell, cookie, cookie_bite, copy, copyright, couch, credit_card, crop, crop_alt, cross, crosshairs, crow, crown, cube, cubes, cut, database, deaf, democrat, desktop, dharmachakra, diagnoses, dice, dice_d20, dice_d6, dice_five, dice_four, dice_one, dice_six, dice_three, dice_two, digital_tachograph, directions, divide, dizzy, dna, dog, dollar_sign, dolly, dolly_flatbed, donate, door_closed, door_open, dot_circle, dove, download, drafting_compass, dragon, draw_polygon, drum, drum_steelpan, drumstick_bite, dumbbell, dumpster, dumpster_fire, dungeon, edit, eject, ellipsis_h, ellipsis_v, envelope, envelope_open, envelope_open_text, envelope_square, equals, eraser, ethernet, euro_sign, exchange_alt, exclamation, exclamation_circle, exclamation_triangle, expand, expand_arrows_alt, external_link_alt, external_link_square_alt, eye, eye_dropper, eye_slash, fast_backward, fast_forward, fax, feather, feather_alt, female, fighter_jet, file, file_alt, file_archive, file_audio, file_code, file_contract, file_csv, file_download, file_excel, file_export, file_image, file_import, file_invoice, file_invoice_dollar, file_medical, file_medical_alt, file_pdf, file_powerpoint, file_prescription, file_signature, file_upload, file_video, file_word, fill, fill_drip, film, filter, fingerprint, fire, fire_alt, fire_extinguisher, first_aid, fish, fist_raised, flag, flag_checkered, flag_usa, flask, flushed, folder, folder_minus, folder_open, folder_plus, font, font_awesome_logo_full, football_ball, forward, frog, frown, frown_open, funnel_dollar, futbol, gamepad, gas_pump, gavel, gem, genderless, ghost, gift, gifts, glass_cheers, glasses, glass_martini, glass_martini_alt, glass_whiskey, globe, globe_africa, globe_americas, globe_asia, globe_europe, golf_ball, gopuram, graduation_cap, greater_than, greater_than_equal, grimace, grin, grin_alt, grin_beam, grin_beam_sweat, grin_hearts, grin_squint, grin_squint_tears, grin_stars, grin_tears, grin_tongue, grin_tongue_squint, grin_tongue_wink, grin_wink, grip_horizontal, grip_lines, grip_lines_vertical, grip_vertical, guitar, hammer, hamsa, hand_holding, hand_holding_heart, hand_holding_usd, hand_lizard, hand_paper, hand_peace, hand_point_down, hand_pointer, hand_point_left, hand_point_right, hand_point_up, hand_rock, hands, hand_scissors, handshake, hands_helping, hand_spock, hanukiah, hashtag, hat_wizard, haykal, hdd, heading, headphones, headphones_alt, headset, heart, heartbeat, heart_broken, helicopter, highlighter, hiking, hippo, history, hockey_puck, holly_berry, home, horse, horse_head, hospital, hospital_alt, hospital_symbol, hotel, hot_tub, hourglass, hourglass_end, hourglass_half, hourglass_start, house_damage, hryvnia, h_square, icicles, i_cursor, id_badge, id_card, id_card_alt, igloo, image, images, inbox, indent, industry, infinity, info, info_circle, italic, jedi, joint, journal_whills, kaaba, key, keyboard, khanda, kiss, kiss_beam, kiss_wink_heart, kiwi_bird, landmark, language, laptop, laptop_code, laugh, laugh_beam, laugh_squint, laugh_wink, layer_group, leaf, lemon, less_than, less_than_equal, level_down_alt, level_up_alt, life_ring, lightbulb, link, lira_sign, list, list_alt, list_ol, list_ul, location_arrow, _lock, lock_open, long_arrow_alt_down, long_arrow_alt_left, long_arrow_alt_right, long_arrow_alt_up, low_vision, luggage_cart, magic, magnet, mail_bulk, male, map, map_marked, map_marked_alt, map_marker, map_marker_alt, map_pin, map_signs, marker, mars, mars_double, mars_stroke, mars_stroke_h, mars_stroke_v, mask, medal, medkit, meh, meh_blank, meh_rolling_eyes, memory, menorah, mercury, meteor, microchip, microphone, microphone_alt, microphone_alt_slash, microphone_slash, microscope, minus, minus_circle, minus_square, mitten, mobile, mobile_alt, money_bill, money_bill_alt, money_bill_wave, money_bill_wave_alt, money_check, money_check_alt, monument, moon, mortar_pestle, mosque, motorcycle, mountain, mouse_pointer, mug_hot, music, network_wired, neuter, newspaper, not_equal, notes_medical, object_group, object_ungroup, oil_can, om, otter, outdent, paint_brush, paint_roller, palette, pallet, paperclip, paper_plane, parachute_box, paragraph, parking, passport, pastafarianism, paste, pause, pause_circle, paw, peace, pen, pen_alt, pencil_alt, pencil_ruler, pen_fancy, pen_nib, pen_square, people_carry, percent, percentage, person_booth, phone, phone_slash, phone_square, phone_volume, piggy_bank, pills, place_of_worship, plane, plane_arrival, plane_departure, play, play_circle, plug, plus, plus_circle, plus_square, podcast, poll, poll_h, poo, poop, poo_storm, portrait, pound_sign, power_off, pray, praying_hands, prescription, prescription_bottle, prescription_bottle_alt, print, procedures, project_diagram, puzzle_piece, qrcode, question, question_circle, quidditch, quote_left, quote_right, quran, radiation, radiation_alt, rainbow, random, receipt, recycle, redo, redo_alt, registered, reply, reply_all, republican, restroom, retweet, ribbon, ring, road, robot, rocket, route, rss, rss_square, ruble_sign, ruler, ruler_combined, ruler_horizontal, ruler_vertical, running, rupee_sign, sad_cry, sad_tear, satellite, satellite_dish, save, school, screwdriver, scroll, sd_card, search, search_dollar, search_location, search_minus, search_plus, seedling, server, shapes, share, share_alt, share_alt_square, share_square, shekel_sign, shield_alt, ship, shipping_fast, shoe_prints, shopping_bag, shopping_basket, shopping_cart, shower, shuttle_van, sign, signal, signature, sign_in_alt, sign_language, sign_out_alt, sim_card, sitemap, skating, skiing, skiing_nordic, skull, skull_crossbones, slash, sleigh, sliders_h, smile, smile_beam, smile_wink, smog, smoking, smoking_ban, sms, snowboarding, snowflake, snowman, snowplow, socks, solar_panel, sort, sort_alpha_down, sort_alpha_up, sort_amount_down, sort_amount_up, sort_down, sort_numeric_down, sort_numeric_up, sort_up, spa, space_shuttle, spider, spinner, splotch, spray_can, square, square_full, square_root_alt, stamp, star, star_and_crescent, star_half, star_half_alt, star_of_david, star_of_life, step_backward, step_forward, stethoscope, sticky_note, stop, stop_circle, stopwatch, store, store_alt, stream, street_view, strikethrough, stroopwafel, subscript, subway, suitcase, suitcase_rolling, sun, superscript, surprise, swatchbook, swimmer, swimming_pool, synagogue, sync, sync_alt, syringe, table, tablet, tablet_alt, table_tennis, tablets, tachometer_alt, tag, tags, tape, tasks, taxi, teeth, teeth_open, temperature_high, temperature_low, tenge, terminal, text_height, text_width, th, theater_masks, thermometer, thermometer_empty, thermometer_full, thermometer_half, thermometer_quarter, thermometer_three_quarters, th_large, th_list, thumbs_down, thumbs_up, thumbtack, ticket_alt, times, times_circle, tint, tint_slash, tired, toggle_off, toggle_on, toilet, toilet_paper, toolbox, tools, tooth, torah, torii_gate, tractor, trademark, traffic_light, train, tram, transgender, transgender_alt, trash, trash_alt, tree, trophy, truck, truck_loading, truck_monster, truck_moving, truck_pickup, tshirt, tty, tv, umbrella, umbrella_beach, underline, undo, undo_alt, universal_access, university, unlink, unlock, unlock_alt, upload, user, user_alt, user_alt_slash, user_astronaut, user_check, user_circle, user_clock, user_cog, user_edit, user_friends, user_graduate, user_injured, user_lock, user_md, user_minus, user_ninja, user_plus, users, users_cog, user_secret, user_shield, user_slash, user_tag, user_tie, user_times, utensils, utensil_spoon, vector_square, venus, venus_double, venus_mars, vial, vials, video, video_slash, vihara, volleyball_ball, volume_down, volume_mute, volume_off, volume_up, vote_yea, vr_cardboard, walking, wallet, warehouse, water, weight, weight_hanging, wheelchair, wifi, wind, window_close, window_maximize, window_minimize, window_restore, wine_bottle, wine_glass, wine_glass_alt, won_sign, wrench, x_ray, yen_sign, yin_yang, _500px, accessible_icon, accusoft, acquisitions_incorporated, adn, adobe, adversal, affiliatetheme, algolia, alipay, amazon, amazon_pay, amilia, android, angellist, angrycreative, angular, apper, apple, apple_pay, app_store, app_store_ios, artstation, asymmetrik, atlassian, audible, autoprefixer, avianex, aviato, aws, bandcamp, behance, behance_square, bimobject, bitbucket, bitcoin, bity, blackberry, black_tie, blogger, blogger_b, bluetooth, bluetooth_b, btc, buromobelexperte, buysellads, canadian_maple_leaf, cc_amazon_pay, cc_amex, cc_apple_pay, cc_diners_club, cc_discover, cc_jcb, cc_mastercard, cc_paypal, cc_stripe, cc_visa, centercode, centos, chrome, cloudscale, cloudsmith, cloudversify, codepen, codiepie, confluence, connectdevelop, contao, cpanel, creative_commons, creative_commons_by, creative_commons_nc, creative_commons_nc_eu, creative_commons_nc_jp, creative_commons_nd, creative_commons_pd, creative_commons_pd_alt, creative_commons_remix, creative_commons_sa, creative_commons_sampling, creative_commons_sampling_plus, creative_commons_share, creative_commons_zero, critical_role, css3, css3_alt, cuttlefish, d_and_d, d_and_d_beyond, dashcube, delicious, deploydog, deskpro, dev, deviantart, dhl, diaspora, digg, digital_ocean, discord, discourse, dochub, docker, draft2digital, dribbble, dribbble_square, dropbox, drupal, dyalog, earlybirds, ebay, edge, elementor, ello, ember, empire, envira, erlang, ethereum, etsy, expeditedssl, facebook, facebook_f, facebook_messenger, facebook_square, fantasy_flight_games, fedex, fedora, figma, firefox, firstdraft, first_order, first_order_alt, flickr, flipboard, fly, font_awesome, font_awesome_alt, font_awesome_flag, fonticons, fonticons_fi, fort_awesome, fort_awesome_alt, forumbee, foursquare, freebsd, free_code_camp, fulcrum, galactic_republic, galactic_senate, get_pocket, gg, gg_circle, git, github, github_alt, github_square, gitkraken, gitlab, git_square, gitter, glide, glide_g, gofore, goodreads, goodreads_g, google, google_drive, google_play, google_plus, google_plus_g, google_plus_square, google_wallet, gratipay, grav, gripfire, grunt, gulp, hacker_news, hacker_news_square, hackerrank, hips, hire_a_helper, hooli, hornbill, hotjar, houzz, html5, hubspot, imdb, instagram, intercom, internet_explorer, invision, ioxhost, itunes, itunes_note, java, jedi_order, jenkins, jira, joget, joomla, js, jsfiddle, js_square, kaggle, keybase, keycdn, kickstarter, kickstarter_k, korvue, laravel, lastfm, lastfm_square, leanpub, less, line, linkedin, linkedin_in, linode, linux, lyft, magento, mailchimp, mandalorian, markdown, mastodon, maxcdn, medapps, medium, medium_m, medrt, meetup, megaport, mendeley, microsoft, mix, mixcloud, mizuni, modx, monero, napster, neos, nimblr, nintendo_switch, node, node_js, npm, ns8, nutritionix, odnoklassniki, odnoklassniki_square, old_republic, opencart, openid, opera, optin_monster, osi, page4, pagelines, palfed, patreon, paypal, penny_arcade, periscope, phabricator, phoenix_framework, phoenix_squadron, php, pied_piper, pied_piper_alt, pied_piper_hat, pied_piper_pp, pinterest, pinterest_p, pinterest_square, playstation, product_hunt, pushed, python, qq, quinscape, quora, raspberry_pi, ravelry, react, reacteurope, readme, rebel, reddit, reddit_alien, reddit_square, redhat, red_river, renren, replyd, researchgate, resolving, rev, rocketchat, rockrms, r_project, safari, sass, schlix, scribd, searchengin, sellcast, sellsy, servicestack, shirtsinbulk, shopware, simplybuilt, sistrix, sith, sketch, skyatlas, skype, slack, slack_hash, slideshare, snapchat, snapchat_ghost, snapchat_square, soundcloud, sourcetree, speakap, spotify, squarespace, stack_exchange, stack_overflow, staylinked, steam, steam_square, steam_symbol, sticker_mule, strava, stripe, stripe_s, studiovinari, stumbleupon, stumbleupon_circle, superpowers, supple, suse, teamspeak, telegram, telegram_plane, tencent_weibo, themeco, themeisle, the_red_yeti, think_peaks, trade_federation, trello, tripadvisor, tumblr, tumblr_square, twitch, twitter, twitter_square, typo3, uber, ubuntu, uikit, uniregistry, untappd, ups, usb, usps, ussunnah, vaadin, viacoin, viadeo, viadeo_square, viber, vimeo, vimeo_square, vimeo_v, vine, vk, vnv, vuejs, weebly, weibo, weixin, whatsapp, whatsapp_square, whmcs, wikipedia_w, windows, wix, wizards_of_the_coast, wolf_pack_battalion, wordpress, wordpress_simple, wpbeginner, wpexplorer, wpforms, wpressr, xbox, xing, xing_square, yahoo, yandex, yandex_international, yarn, y_combinator, yelp, yoast, youtube, youtube_square, zhihu, address_book_o, address_card_o, vcard_o, vcard, signing, asl_interpreting, arrow_circle_o_down, arrow_circle_o_left, arrow_circle_o_right, arrow_circle_o_up, arrows, arrows_h, arrows_v, reorder, navicon, bathtub, s15, battery_0, battery, battery_4, battery_2, battery_1, battery_3, bell_o, bell_slash_o, flash, bookmark_o, building_o, calendar_o, calendar_check_o, calendar_minus_o, calendar_plus_o, calendar_times_o, automobile, caret_square_o_down, caret_square_o_left, caret_square_o_right, toggle_down, toggle_left, toggle_right, caret_square_o_up, toggle_up, area_chart, bar_chart_o, bar_chart, line_chart, pie_chart, check_circle_o, check_square_o, circle_o, circle_thin, circle_o_notch, clock_o, cloud_download, cloud_upload, code_fork, gear, gears, comment_o, commenting, commenting_o, comments_o, files_o, credit_card_alt, cc, scissors, deafness, hard_of_hearing, usd, dollar, dot_circle_o, envelope_o, envelope_open_o, euro, eur, exchange, warning, external_link_square, external_link, eyedropper, file_o, file_text_o, file_text, file_zip_o, file_archive_o, file_audio_o, file_sound_o, file_code_o, file_excel_o, file_photo_o, file_picture_o, file_image_o, file_pdf_o, file_powerpoint_o, file_movie_o, file_video_o, file_word_o, flag_o, folder_o, folder_open_o, frown_o, futbol_o, soccer_ball_o, legal, diamond, mortar_board, hand_lizard_o, hand_paper_o, hand_stop_o, hand_peace_o, hand_o_down, hand_pointer_o, hand_o_left, hand_o_right, hand_o_up, hand_rock_o, hand_grab_o, hand_scissors_o, handshake_o, hand_spock_o, hdd_o, header, heart_o, hospital_o, hourglass_o, hourglass_1, hourglass_2, hourglass_3, drivers_license_o, drivers_license, id_card_o, photo, picture_o, keyboard_o, lemon_o, level_down, level_up, life_bouy, life_buoy, support, life_saver, lightbulb_o, chain, turkish_lira, _try, long_arrow_down, long_arrow_left, long_arrow_right, long_arrow_up, map_o, meh_o, minus_square_o, money, moon_o, newspaper_o, dedent, send, paper_plane_o, send_o, pause_circle_o, pencil_square, pencil_square_o, pencil, mobile_phone, volume_control_phone, bank, plus_square_o, play_circle_o, gbp, question_circle_o, rotate_right, repeat, mail_reply, mail_reply_all, feed, rouble, ruble, rub, inr, rupee, floppy_o, mail_forward, share_square_o, ils, shekel, sheqel, shield, sign_in, sign_out, sliders, smile_o, snowflake_o, unsorted, sort_alpha_asc, sort_alpha_desc, sort_amount_asc, sort_amount_desc, sort_asc, sort_numeric_asc, sort_numeric_desc, sort_desc, square_o, star_o, star_half_empty, star_half_o, star_half_full, sticky_note_o, stop_circle_o, sun_o, refresh, tachometer, dashboard, cab, thermometer_0, thermometer_4, thermometer_2, thermometer_1, thermometer_3, thumb_tack, thumbs_o_down, thumbs_o_up, ticket, times_rectangle, remove, times_rectangle_o, times_circle_o, intersex, trash_o, television, rotate_left, institution, chain_broken, user_o, user_circle_o, group, cutlery, spoon, wheelchair_alt, window_close_o, close, glass, won, krw, cny, jpy, yen, rmb, bitbucket_square, ge, facebook_official, fa, google_plus_official, google_plus_circle, gittip, linkedin_square, ra, resistance, eercast, yc, y_combinator_square, yc_square, youtube_play

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconAlignment
The icon alignment. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: left, right

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the component.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnClick
An event handler that is called when the button is clicked. This can be either a ScriptBlock or a UDEndpoint.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The test to display on the button.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
