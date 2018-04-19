% Michael Pollard
% CSCI 305 Prolog Lab 2

% Rules that find a childs mother or father using the parent rule and checking the gender.
mother(Mother, Child):- parent(Mother, Child), female(Mother).
father(Father, Child):- parent(Father, Child), male(Father).

% Rules to find who is a spouse to who using the married rule from royal.pl.
% Two rules were used so the argument order from the user query wouldn't matter.
spouse(Person1, Person2):- married(Person1, Person2).
spouse(Person1, Person2):- married(Person2, Person1).

% This rule uses the inverse of the parent rule to find the child.
child(Child, Parent):- parent(Parent, Child).

% Rules to determine son or daughter depending on the gender.
son(Son, Parent):- child(Son, Parent), male(Son).
daughter(Daughter, Parent):- child(Daughter, Parent), female(Daughter).

% This Rule finds if two people have the same parents and if so, declares them as siblings.
% The dif rule ensures a person is not a sibling to themselves.
sibling(Person1, Person2):- parent(Parent, Person1), parent(Parent, Person2), dif(Person1, Person2).

% Rules that use sibling rule to check if they are siblings but also checks for gender.
brother(Brother, Sibling):- sibling(Brother, Sibling), male(Brother).
sister(Sister, Sibling):- sibling(Sister, Sibling), female(Sister).

% Rules that find the uncle of a person, first rule is through blood, second is through marriage.
uncle(Uncle, Person):- parent(Parent, Person), brother(Uncle, Parent).
uncle(Uncle, Person):- parent(Parent, Person), sibling(Parent, UnclesWife), spouse(Uncle, UnclesWife), male(Uncle).

% Rules that find the Aunt of a person, first rule is through blood, second is through marriage.
aunt(Aunt, Person):- parent(Parent, Person), sister(Aunt, Parent).
aunt(Aunt, Person):- parent(Parent, Person), sibling(Parent, AuntsHusband), spouse(Aunt, AuntsHusband), female(Aunt).

% This Rule finds a person's parent's parent, the grandparent.
grandparent(Grandparent, Person):- parent(Parent, Person), parent(Grandparent, Parent).

% Rules that use the grandparent rule but check for gender as well.
grandfather(Grandfather, Person):- grandparent(Grandfather, Person), male(Grandfather).
grandmother(Grandmother, Person):- grandparent(Grandmother, Person), female(Grandmother).

% This rule uses the inverse of the grandparent rule to the grandchild.
grandchild(Grandchild, Grandparent):- grandparent(Grandparent, Grandchild).

% This rule recursively finds all the parents of a person with two rules.
ancestor(Ancestor, Person):- parent(Ancestor, Person).
ancestor(Ancestor, Person):- parent(Parent, Person), ancestor(Ancestor, Parent).

% This rule uses the inverse of ancestor to find the descendant.
descendant(Descendant, Person):- ancestor(Person, Descendant).

% This rule compares the age of two people and returns true if Person1 is older and false otherwise.
% note: older people will have a numerically smaller birth year.
older(Person1, Person2):- born(Person1, Person1BirthYear), born(Person2, Person2BirthYear), Person1BirthYear < Person2BirthYear.

% This rule inverses the arguments in the older rule to find the younger person.
younger(Person1, Person2):- older(Person2, Person1).

% This rule finds who was born when a certain regent was ruling using the start and end dates of the ruling and birth year.
regentWhenBorn(Ruler, Person):- reigned(Ruler, StartYear, EndYear), born(Person, YearBorn), YearBorn > StartYear, YearBorn < EndYear.

% In this rule, child 1 and 2 are cousins if their parents are sibling.
cousin(Child1, Child2):- parent(Parent1, Child1), parent(Parent2, Child2), sibling(Parent1, Parent2).
