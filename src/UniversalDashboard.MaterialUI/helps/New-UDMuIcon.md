---
external help file: UniversalDashboard.MaterialUI-help.xml
Module Name: UniversalDashboard.MaterialUI
online version:
schema: 2.0.0
---

# New-UDMuIcon

## SYNOPSIS
Create icon from the FontAwesome pack

## SYNTAX

```
New-UDMuIcon [[-Id] <String>] [[-Icon] <FontAwesomeIcons>] [-FixedWidth] [-Inverse] [[-Rotation] <Int32>]
 [[-ClassName] <String>] [[-Transform] <String>] [[-Flip] <String>] [[-Pull] <String>] [-ListItem] [-Spin]
 [-Border] [-Pulse] [[-Size] <String>] [[-Style] <Hashtable>] [[-Title] <String>] [-Regular]
 [<CommonParameters>]
```

## DESCRIPTION
This command will generate an svg icon from the FontAwesome library, this icons comes from the Solid,Brand and regular packages.
The library include 1300+ icons.

## EXAMPLES

### Example 1
```powershell
PS C:\>  New-UDMuIcon -Icon box -Style @{color = '#000'} -Id 'test-icon-button' 
```

Create icon with the default size sm and it has black color.

### Example 2
```powershell
PS C:\>  New-UDMuIcon -Icon spinner -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' -Spin
```

Create icon that has spin animation.

### Example 3
```powershell
PS C:\>  New-UDMuIcon -Icon angry -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' -Regular
```

Create angey icon that have a size of 3 and black color, and also this icon is from the FontAwesome regular pack ( semi light ) style.

## PARAMETERS

### -Border
set square border around the icon

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

### -ClassName
Add custom css class name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FixedWidth
 set the icons to the same fixed width

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

### -Flip
Flip horizontally, vertically, or both

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: horizontal, vertical, both

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
{{Fill Icon Description}}

```yaml
Type: FontAwesomeIcons
Parameter Sets: (All)
Aliases:
Accepted values: None, ad, address_book, address_card, adjust, air_freshener, align_center, align_justify, align_left, align_right, allergies, ambulance, american_sign_language_interpreting, anchor, angle_double_down, angle_double_left, angle_double_right, angle_double_up, angle_down, angle_left, angle_right, angle_up, angry, ankh, apple_alt, archive, archway, arrow_alt_circle_down, arrow_alt_circle_left, arrow_alt_circle_right, arrow_alt_circle_up, arrow_circle_down, arrow_circle_left, arrow_circle_right, arrow_circle_up, arrow_down, arrow_left, arrow_right, arrows_alt, arrows_alt_h, arrows_alt_v, arrow_up, assistive_listening_systems, asterisk, at, atlas, atom, audio_description, award, baby, baby_carriage, backspace, backward, balance_scale, ban, band_aid, barcode, bars, baseball_ball, basketball_ball, bath, battery_empty, battery_full, battery_half, battery_quarter, battery_three_quarters, bed, beer, bell, bell_slash, bezier_curve, bible, bicycle, binoculars, biohazard, birthday_cake, blender, blender_phone, blind, blog, bold, bolt, bomb, bone, bong, book, book_dead, bookmark, book_open, book_reader, bowling_ball, box, boxes, box_open, braille, brain, briefcase, briefcase_medical, broadcast_tower, broom, brush, bug, building, bullhorn, bullseye, burn, bus, bus_alt, business_time, calculator, calendar, calendar_alt, calendar_check, calendar_day, calendar_minus, calendar_plus, calendar_times, calendar_week, camera, camera_retro, campground, candy_cane, cannabis, capsules, car, car_alt, car_battery, car_crash, caret_down, caret_left, caret_right, caret_square_down, caret_square_left, caret_square_right, caret_square_up, caret_up, carrot, car_side, cart_arrow_down, cart_plus, cash_register, cat, certificate, chair, chalkboard, chalkboard_teacher, charging_station, chart_area, chart_bar, chart_line, chart_pie, check, check_circle, check_double, check_square, chess, chess_bishop, chess_board, chess_king, chess_knight, chess_pawn, chess_queen, chess_rook, chevron_circle_down, chevron_circle_left, chevron_circle_right, chevron_circle_up, chevron_down, chevron_left, chevron_right, chevron_up, child, church, circle, circle_notch, city, clipboard, clipboard_check, clipboard_list, clock, clone, closed_captioning, cloud, cloud_download_alt, cloud_meatball, cloud_moon, cloud_moon_rain, cloud_rain, cloud_showers_heavy, cloud_sun, cloud_sun_rain, cloud_upload_alt, cocktail, code, code_branch, coffee, cog, cogs, coins, columns, comment, comment_alt, comment_dollar, comment_dots, comments, comments_dollar, comment_slash, compact_disc, compass, compress, compress_arrows_alt, concierge_bell, cookie, cookie_bite, copy, copyright, couch, credit_card, crop, crop_alt, cross, crosshairs, crow, crown, cube, cubes, cut, database, deaf, democrat, desktop, dharmachakra, diagnoses, dice, dice_d20, dice_d6, dice_five, dice_four, dice_one, dice_six, dice_three, dice_two, digital_tachograph, directions, divide, dizzy, dna, dog, dollar_sign, dolly, dolly_flatbed, donate, door_closed, door_open, dot_circle, dove, download, drafting_compass, dragon, draw_polygon, drum, drum_steelpan, drumstick_bite, dumbbell, dumpster, dumpster_fire, dungeon, edit, eject, ellipsis_h, ellipsis_v, envelope, envelope_open, envelope_open_text, envelope_square, equals, eraser, ethernet, euro_sign, exchange_alt, exclamation, exclamation_circle, exclamation_triangle, expand, expand_arrows_alt, external_link_alt, external_link_square_alt, eye, eye_dropper, eye_slash, fast_backward, fast_forward, fax, feather, feather_alt, female, fighter_jet, file, file_alt, file_archive, file_audio, file_code, file_contract, file_csv, file_download, file_excel, file_export, file_image, file_import, file_invoice, file_invoice_dollar, file_medical, file_medical_alt, file_pdf, file_powerpoint, file_prescription, file_signature, file_upload, file_video, file_word, fill, fill_drip, film, filter, fingerprint, fire, fire_alt, fire_extinguisher, first_aid, fish, fist_raised, flag, flag_checkered, flag_usa, flask, flushed, folder, folder_minus, folder_open, folder_plus, font, font_awesome_logo_full, football_ball, forward, frog, frown, frown_open, funnel_dollar, futbol, gamepad, gas_pump, gavel, gem, genderless, ghost, gift, gifts, glass_cheers, glasses, glass_martini, glass_martini_alt, glass_whiskey, globe, globe_africa, globe_americas, globe_asia, globe_europe, golf_ball, gopuram, graduation_cap, greater_than, greater_than_equal, grimace, grin, grin_alt, grin_beam, grin_beam_sweat, grin_hearts, grin_squint, grin_squint_tears, grin_stars, grin_tears, grin_tongue, grin_tongue_squint, grin_tongue_wink, grin_wink, grip_horizontal, grip_lines, grip_lines_vertical, grip_vertical, guitar, hammer, hamsa, hand_holding, hand_holding_heart, hand_holding_usd, hand_lizard, hand_paper, hand_peace, hand_point_down, hand_pointer, hand_point_left, hand_point_right, hand_point_up, hand_rock, hands, hand_scissors, handshake, hands_helping, hand_spock, hanukiah, hashtag, hat_wizard, haykal, hdd, heading, headphones, headphones_alt, headset, heart, heartbeat, heart_broken, helicopter, highlighter, hiking, hippo, history, hockey_puck, holly_berry, home, horse, horse_head, hospital, hospital_alt, hospital_symbol, hotel, hot_tub, hourglass, hourglass_end, hourglass_half, hourglass_start, house_damage, hryvnia, h_square, icicles, i_cursor, id_badge, id_card, id_card_alt, igloo, image, images, inbox, indent, industry, infinity, info, info_circle, italic, jedi, joint, journal_whills, kaaba, key, keyboard, khanda, kiss, kiss_beam, kiss_wink_heart, kiwi_bird, landmark, language, laptop, laptop_code, laugh, laugh_beam, laugh_squint, laugh_wink, layer_group, leaf, lemon, less_than, less_than_equal, level_down_alt, level_up_alt, life_ring, lightbulb, link, lira_sign, list, list_alt, list_ol, list_ul, location_arrow, _lock, lock_open, long_arrow_alt_down, long_arrow_alt_left, long_arrow_alt_right, long_arrow_alt_up, low_vision, luggage_cart, magic, magnet, mail_bulk, male, map, map_marked, map_marked_alt, map_marker, map_marker_alt, map_pin, map_signs, marker, mars, mars_double, mars_stroke, mars_stroke_h, mars_stroke_v, mask, medal, medkit, meh, meh_blank, meh_rolling_eyes, memory, menorah, mercury, meteor, microchip, microphone, microphone_alt, microphone_alt_slash, microphone_slash, microscope, minus, minus_circle, minus_square, mitten, mobile, mobile_alt, money_bill, money_bill_alt, money_bill_wave, money_bill_wave_alt, money_check, money_check_alt, monument, moon, mortar_pestle, mosque, motorcycle, mountain, mouse_pointer, mug_hot, music, network_wired, neuter, newspaper, not_equal, notes_medical, object_group, object_ungroup, oil_can, om, otter, outdent, paint_brush, paint_roller, palette, pallet, paperclip, paper_plane, parachute_box, paragraph, parking, passport, pastafarianism, paste, pause, pause_circle, paw, peace, pen, pen_alt, pencil_alt, pencil_ruler, pen_fancy, pen_nib, pen_square, people_carry, percent, percentage, person_booth, phone, phone_slash, phone_square, phone_volume, piggy_bank, pills, place_of_worship, plane, plane_arrival, plane_departure, play, play_circle, plug, plus, plus_circle, plus_square, podcast, poll, poll_h, poo, poop, poo_storm, portrait, pound_sign, power_off, pray, praying_hands, prescription, prescription_bottle, prescription_bottle_alt, print, procedures, project_diagram, puzzle_piece, qrcode, question, question_circle, quidditch, quote_left, quote_right, quran, radiation, radiation_alt, rainbow, random, receipt, recycle, redo, redo_alt, registered, reply, reply_all, republican, restroom, retweet, ribbon, ring, road, robot, rocket, route, rss, rss_square, ruble_sign, ruler, ruler_combined, ruler_horizontal, ruler_vertical, running, rupee_sign, sad_cry, sad_tear, satellite, satellite_dish, save, school, screwdriver, scroll, sd_card, search, search_dollar, search_location, search_minus, search_plus, seedling, server, shapes, share, share_alt, share_alt_square, share_square, shekel_sign, shield_alt, ship, shipping_fast, shoe_prints, shopping_bag, shopping_basket, shopping_cart, shower, shuttle_van, sign, signal, signature, sign_in_alt, sign_language, sign_out_alt, sim_card, sitemap, skating, skiing, skiing_nordic, skull, skull_crossbones, slash, sleigh, sliders_h, smile, smile_beam, smile_wink, smog, smoking, smoking_ban, sms, snowboarding, snowflake, snowman, snowplow, socks, solar_panel, sort, sort_alpha_down, sort_alpha_up, sort_amount_down, sort_amount_up, sort_down, sort_numeric_down, sort_numeric_up, sort_up, spa, space_shuttle, spider, spinner, splotch, spray_can, square, square_full, square_root_alt, stamp, star, star_and_crescent, star_half, star_half_alt, star_of_david, star_of_life, step_backward, step_forward, stethoscope, sticky_note, stop, stop_circle, stopwatch, store, store_alt, stream, street_view, strikethrough, stroopwafel, subscript, subway, suitcase, suitcase_rolling, sun, superscript, surprise, swatchbook, swimmer, swimming_pool, synagogue, sync, sync_alt, syringe, table, tablet, tablet_alt, table_tennis, tablets, tachometer_alt, tag, tags, tape, tasks, taxi, teeth, teeth_open, temperature_high, temperature_low, tenge, terminal, text_height, text_width, th, theater_masks, thermometer, thermometer_empty, thermometer_full, thermometer_half, thermometer_quarter, thermometer_three_quarters, th_large, th_list, thumbs_down, thumbs_up, thumbtack, ticket_alt, times, times_circle, tint, tint_slash, tired, toggle_off, toggle_on, toilet, toilet_paper, toolbox, tools, tooth, torah, torii_gate, tractor, trademark, traffic_light, train, tram, transgender, transgender_alt, trash, trash_alt, tree, trophy, truck, truck_loading, truck_monster, truck_moving, truck_pickup, tshirt, tty, tv, umbrella, umbrella_beach, underline, undo, undo_alt, universal_access, university, unlink, unlock, unlock_alt, upload, user, user_alt, user_alt_slash, user_astronaut, user_check, user_circle, user_clock, user_cog, user_edit, user_friends, user_graduate, user_injured, user_lock, user_md, user_minus, user_ninja, user_plus, users, users_cog, user_secret, user_shield, user_slash, user_tag, user_tie, user_times, utensils, utensil_spoon, vector_square, venus, venus_double, venus_mars, vial, vials, video, video_slash, vihara, volleyball_ball, volume_down, volume_mute, volume_off, volume_up, vote_yea, vr_cardboard, walking, wallet, warehouse, water, weight, weight_hanging, wheelchair, wifi, wind, window_close, window_maximize, window_minimize, window_restore, wine_bottle, wine_glass, wine_glass_alt, won_sign, wrench, x_ray, yen_sign, yin_yang, _500px, accessible_icon, accusoft, acquisitions_incorporated, adn, adobe, adversal, affiliatetheme, algolia, alipay, amazon, amazon_pay, amilia, android, angellist, angrycreative, angular, apper, apple, apple_pay, app_store, app_store_ios, artstation, asymmetrik, atlassian, audible, autoprefixer, avianex, aviato, aws, bandcamp, behance, behance_square, bimobject, bitbucket, bitcoin, bity, blackberry, black_tie, blogger, blogger_b, bluetooth, bluetooth_b, btc, buromobelexperte, buysellads, canadian_maple_leaf, cc_amazon_pay, cc_amex, cc_apple_pay, cc_diners_club, cc_discover, cc_jcb, cc_mastercard, cc_paypal, cc_stripe, cc_visa, centercode, centos, chrome, cloudscale, cloudsmith, cloudversify, codepen, codiepie, confluence, connectdevelop, contao, cpanel, creative_commons, creative_commons_by, creative_commons_nc, creative_commons_nc_eu, creative_commons_nc_jp, creative_commons_nd, creative_commons_pd, creative_commons_pd_alt, creative_commons_remix, creative_commons_sa, creative_commons_sampling, creative_commons_sampling_plus, creative_commons_share, creative_commons_zero, critical_role, css3, css3_alt, cuttlefish, d_and_d, d_and_d_beyond, dashcube, delicious, deploydog, deskpro, dev, deviantart, dhl, diaspora, digg, digital_ocean, discord, discourse, dochub, docker, draft2digital, dribbble, dribbble_square, dropbox, drupal, dyalog, earlybirds, ebay, edge, elementor, ello, ember, empire, envira, erlang, ethereum, etsy, expeditedssl, facebook, facebook_f, facebook_messenger, facebook_square, fantasy_flight_games, fedex, fedora, figma, firefox, firstdraft, first_order, first_order_alt, flickr, flipboard, fly, font_awesome, font_awesome_alt, font_awesome_flag, fonticons, fonticons_fi, fort_awesome, fort_awesome_alt, forumbee, foursquare, freebsd, free_code_camp, fulcrum, galactic_republic, galactic_senate, get_pocket, gg, gg_circle, git, github, github_alt, github_square, gitkraken, gitlab, git_square, gitter, glide, glide_g, gofore, goodreads, goodreads_g, google, google_drive, google_play, google_plus, google_plus_g, google_plus_square, google_wallet, gratipay, grav, gripfire, grunt, gulp, hacker_news, hacker_news_square, hackerrank, hips, hire_a_helper, hooli, hornbill, hotjar, houzz, html5, hubspot, imdb, instagram, intercom, internet_explorer, invision, ioxhost, itunes, itunes_note, java, jedi_order, jenkins, jira, joget, joomla, js, jsfiddle, js_square, kaggle, keybase, keycdn, kickstarter, kickstarter_k, korvue, laravel, lastfm, lastfm_square, leanpub, less, line, linkedin, linkedin_in, linode, linux, lyft, magento, mailchimp, mandalorian, markdown, mastodon, maxcdn, medapps, medium, medium_m, medrt, meetup, megaport, mendeley, microsoft, mix, mixcloud, mizuni, modx, monero, napster, neos, nimblr, nintendo_switch, node, node_js, npm, ns8, nutritionix, odnoklassniki, odnoklassniki_square, old_republic, opencart, openid, opera, optin_monster, osi, page4, pagelines, palfed, patreon, paypal, penny_arcade, periscope, phabricator, phoenix_framework, phoenix_squadron, php, pied_piper, pied_piper_alt, pied_piper_hat, pied_piper_pp, pinterest, pinterest_p, pinterest_square, playstation, product_hunt, pushed, python, qq, quinscape, quora, raspberry_pi, ravelry, react, reacteurope, readme, rebel, reddit, reddit_alien, reddit_square, redhat, red_river, renren, replyd, researchgate, resolving, rev, rocketchat, rockrms, r_project, safari, sass, schlix, scribd, searchengin, sellcast, sellsy, servicestack, shirtsinbulk, shopware, simplybuilt, sistrix, sith, sketch, skyatlas, skype, slack, slack_hash, slideshare, snapchat, snapchat_ghost, snapchat_square, soundcloud, sourcetree, speakap, spotify, squarespace, stack_exchange, stack_overflow, staylinked, steam, steam_square, steam_symbol, sticker_mule, strava, stripe, stripe_s, studiovinari, stumbleupon, stumbleupon_circle, superpowers, supple, suse, teamspeak, telegram, telegram_plane, tencent_weibo, themeco, themeisle, the_red_yeti, think_peaks, trade_federation, trello, tripadvisor, tumblr, tumblr_square, twitch, twitter, twitter_square, typo3, uber, ubuntu, uikit, uniregistry, untappd, ups, usb, usps, ussunnah, vaadin, viacoin, viadeo, viadeo_square, viber, vimeo, vimeo_square, vimeo_v, vine, vk, vnv, vuejs, weebly, weibo, weixin, whatsapp, whatsapp_square, whmcs, wikipedia_w, windows, wix, wizards_of_the_coast, wolf_pack_battalion, wordpress, wordpress_simple, wpbeginner, wpexplorer, wpforms, wpressr, xbox, xing, xing_square, yahoo, yandex, yandex_international, yarn, y_combinator, yelp, yoast, youtube, youtube_square, zhihu

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Set css id property

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

### -Inverse
{{Fill Inverse Description}}

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

### -ListItem
{{Fill ListItem Description}}

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

### -Pull
{{Fill Pull Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: right, left

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pulse
Use this to have the icon to rotate with 8 steps

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

### -Regular
This switch if define will search the icon in the FontAwesome regular pack, if the icon is not in the regular pack the command will used the fallback icon in the solid pack.

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

### -Rotation
Wil rotate the icon by 90 degress 

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Size
Set the size of the icon

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: xs, sm, lg, 2x, 3x, 4x, 5x, 6x, 7x, 8x, 9x, 10x

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Spin
Will spin the icon like loading animation

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

### -Style
Set css attributes on the icon like color etc...

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
{{Fill Title Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Transform
Thanks to the power of SVG in Font Awesome 5, you can scale, position, flip, & rotate icons arbitrarily using the data-fa-transform element attribute. You can even combine them for some super-useful effects.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
