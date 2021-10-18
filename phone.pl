#!/usr/bin/perl

# Prompt the user to enter first or last or any portion of person’s name
print("Enter first or last or any portion of person’s name: ");
$name=<>;

chop($name);

# Open the phone directory file
open('DATA', "<phones") or die "Unable to open the phone directory.\n";

# Initialize name found flag
$found = 0;

# Loop through each line of the phone directory
while (<DATA>) {
    # Break the line separated by spaces
    my @spl = split(' ', $_);
    
    # Read the name from the first two strings in the line
    $first = lc @spl[0];
    $last = lc @spl[1];
    
    # Check if the first or last name contains the input in part or whole
    if ((index($first, $name) != -1) || (index($last, $name) != -1)) {
        # Set the name found flag
        $found=1;

        # Print the name
        print($_);

        # Do not exit loop as to print all matching names
    }
}

if (!$found) {
    print("$name NOT found in the phone directory file!\n");
}

close(DATA);
