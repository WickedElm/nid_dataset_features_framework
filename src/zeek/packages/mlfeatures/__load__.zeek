###
# Set up our machine learning features log to piggy-back off of conn.log
###

@load ./main

###
# Each script below represents the definition of a single feature
# included in our features log.
###

@load ./features/packets

###
# Below are the explicit labeling routines for the data.
###

@load ./label/label
