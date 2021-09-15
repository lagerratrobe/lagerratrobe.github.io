---
layout: post
title: Ebike Conversion Explained
date: 2021-9-13 11:00
---

Ebike sales have exploded between 2019 and 2021, with some sources [claiming an increase in U.S. sales of 145%](https://cyclingindustry.news/e-bike-sales-3-7m-17m-2030-industry-experts/) in 2020.  Lockdowns and work-from-home edicts due to COVID have made people crave outdoor activites, as well as making them look at transportation alternatives to using the bus.  Sales have also been helped by this surge in popularity coming at a time when battery, motor and controller technology have reached a standard of reliability and performance that was previously unavailable.  As a result, ebikes are easier to find now than they ever have been.

Complete ebikes are now being made and sold by [large retailers like REI's Coop Cycles](https://electrek.co/2021/07/21/rei-cty-review-a-sleek-commuter-from-an-outdoors-company/){:target="_blank"} and niche brands like Rad Power and Pedego - who have been selling models succesfully since 2015 and earlier - have made it easy to purchase a bike Online, or have showrooms located across the country.  To support this growing market, established bicycle component manufacturers like Shimano have ramped up their production of ebike systems for OEM bike makers, as have companies with experience in other categories of electric transportation, such as BOSCH and Bafang .  Bafang in particular has become a leader in the ebike conversion market, selling complete kits to convert existing bicycles into ebikes.

_Note that my definition of OEM is based on the computer industry version of the term, where "OEM" refers to the company that buys products and then incorporates or rebrands them into a new product under its own name._

## Rationale for Conversion

For me, the idea of an ebike was attractive as a means of flattening the hills in the area that I live in.  I already had a nice bike that I built a few years ago based on a [Soma Fabrications Saga frameset](https://www.somafab.com/archives/product/saga-disc-frame-set).  It has a strong frame, disk brakes and wheels that I had custom built to carry my weight, but I hated riding it around Seattle.

From a commuting standpoint, Seattle has one of the worst road networks for regional bicycle travel that I've ever seen.  Travelling any real distance involves navigating a disconnected mess of "bike **un**-friendly" roads that are narrow, filled with parked cars and, because of the concrete road surface that Seattle loves so much, miserable to ride on.  So regional commuting is out. Local trips though, are a different story.  They still use the same terrible road system, but for short rides to-and-from the post office, or the grocery store, it's possible to tune the route and do more of a "combat style" of riding that incorporates sidewalks, alleys etc. (_Yes, haters can flame me for this.  [I care, I really do]({{ site.baseurl }}/images/honey-badger.jpg){:target="_blank"}_)

I wanted to make my bike rideable for running short errands that seem wasteful to use a car for; getting a six-pack of beer, dropping off an Amazon return, picking up heartworm medicine from the vet - that sort of thing.  These things could all be done on foot, but I'm lazy and my time is worth something to me.  So I chose to convert my Soma by adding a mid-drive  conversion kit from Bafang to it.

## Types of Electric Motor Systems

In terms of popularity, there are essentially 2 types of drive systems available for ebikes; wheel hub motors and mid-drive motors.  (_A 3rd type, the friction drive, exists but no one uses it._)  Generally speaking, most manufacturers of complete ebikes use one of these 2 types of drive system.  Pedego and Rad Power seem to prefer hub motors for their bikes, REI and other larger OEMs seem to use mid-drive systems.  _Note that I don't think these makers are locked into these choices, I just mention them as examples to see one type of system versus another._

* Hub motors work by placing the electric motor inside the wheel hub, either front or rear, to directly drive the wheel.  Below is an image of a hub motor with its cover removed, showing the copper windings and other guts that make it go.
![hub-motor]({{ site.baseurl }}/images/hub_motor.jpg)

* Mid-drive systems place the motor in the center of the bike, similar to how a motorcycle engine is located, albeit much, much smaller.  Here is an example of a mid-drive from BOSCH. ![hub-motor]({{ site.baseurl }}/images/mid-drive-motor.jpg)

Both systems work well and neither is better than the other (_despite what certain makers would like you to believe_). Hub motor systems generally have fewer moving parts but require a separate location for the controller. Mid-drive systems can provide more torque because they use the bike's existing gears and drivetrain, but this comes at the expense of accelerated chain and cassette wear.  For a new bike, I think the choice is entirely up to the user and should be based on the features they're looking for and the price they're willing to pay.  For a conversion though, unless you want to have a new wheel made to accomodate the hub motor, certain types of mid-drive, like the Bafang BBSHD, are much simpler to install.

After doing some research, I decided to get a Bafang BBSHD mid-drive kit from [Empowered Cycles](https://www.empoweredcycles.com/){:target="_blank"} in San Francisco.  These come in various sizes to fit the variability in frame sizes and the owner, Matt, has been very helpful in answering questions.

## Bafang Mid Drive System

The Bafang mid-drive system contains the major components shown below.
![hub-motor]({{ site.baseurl }}/images/ebike_system.jpg)

* __Left (and Right) e-brakes:__ these are standard brake levers with the addition of electric switches which activate when the brakes are activated.  They kill motor power when the rider activates the brakes, which I find useful when coming to a stop at a streetlight, especially when I'm downshifting just prior to stopping entirely.
* __Display:__ speedometer and onboard motor controls.  These displays vary quite a bit, but at a basic level this is where you turn the system on and where you specify how much Assistance is being given in Pedal Assist mode. Some displays also show watt consumption and allow you to control lights and other features as well.
* __Throttle:__ basic potentiometer swicth that allows the rider to override the Pedal Assist and operate the motor,  Similar to how a motorcycle throttle works, but with differences based on how the motor controller is configured.
* __Motor:__ self-explanatory, but this is what provides the actual motive power to the bike.  Worth noting here is that the motor housing also contains the controller and primary and secondary gear reduction.
* __Battery pack:__ self explanatory.  Major differences exist between the voltage and capacity available with various batteries, but by default this system runs on 48 volts at 30 amps.
* __Shift sensor:__ senses when the rider changes gears and momentarily cuts power to the motor when it senses the derrailleur cable moving.
* __Speed sensor:__ essentially the heart of the control system.  In conjunction with a sensor that detects when the pedals are moving (forward), and the PAS setting on the display, the speed sensor helps the motor determine how much power to provide.  In general, the power that the motor provides is a function of the percantage of the maximum speed the system is configured for and the PAS level.
*

## Motor Install details

![Soma_Conversion]({{ site.baseurl }}/images/soma_conversion.png)

Probably the most confusing aspect about these mid-drive conversion kits is regarding how the motor is actually attached to the frame of the bike.  Essentially, the entire crank set is removed and replaced by the motor installation.  The pedal spindle becomes the mounting point off of which the motor housing hangs.

* Here is what the original crank installation looks like on the Soma.

![Original Cranks]({{ site.baseurl }}/images/soma_orig_cranks.jpg)

* As you can see below, the original crank set is installed into the bottom bracket through the large hole that is the actual bottom bracket.

![Bottom Bracket]({{ site.baseurl }}/images/soma_bottom_bracket.jpg)

* The BBSHD has a pedal spindle that is an integral part of the motor housing.

![BBSHD Motor]({{ site.baseurl }}/images/BBSHD_Motor.jpg)


* This is what the BBSHD looks like installed in the same place as the original cranks.  You can see the pedal spindle coming through the bottom bracket.

![Bafang Install]({{ site.baseurl }}/images/bafang_motor_installed.jpg)


## To be Continued...