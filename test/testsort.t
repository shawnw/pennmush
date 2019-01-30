# Assumes that LC_COLLATE is set to C
login mortal
run tests:
# Sort
# Stripping markup and integer autodetect
$mortal->command('@set me=!ansi');
test('sort.1', $mortal, 'think sort(a [ansi(h,a)] b [ansi(h,b)] c d [ansi(h,e)] f)', 'a a b b c d e f');
test('sort.2', $mortal, 'think sort(3 [ansi(h,1)] [ansi(y,7)] 5)', '1 3 5 7');

# dbref sorts
test('sort.3', $mortal, 'think sort(#1 #3 #2)', '#1 #2 #3');
test('sort.4', $mortal, 'think sort(#1 #3 #2, d)', '#1 #2 #3');
test('sort.5', $mortal, 'think sort(#1 #3 #2, -d)', '#3 #2 #1');

# integer sorts
test('sort.6', $mortal, 'think sort(1 5 2, n)', '1 2 5');
test('sort.7', $mortal, 'think sort(1 5 2, -n)', '5 2 1');

# floating point sorts
test('sort.8', $mortal, 'think sort(0.0 -1.5 1.5 9 10.1)', '-1.5 0.0 1.5 9 10.1');
test('sort.9', $mortal, 'think sort(0.0 -1.5 1.5 9 10.1, f)', '-1.5 0.0 1.5 9 10.1');
test('sort.10', $mortal, 'think sort(0.0 -1.5 1.5 9 10.1, -f)', '10.1 9 1.5 0.0 -1.5');

# lexicographic sorts
test('sort.11', $mortal, 'think sort(the quick brown dog, l)', 'brown dog quick the');
test('sort.12', $mortal, 'think sort(The quick Brown dog, l)', 'Brown The dog quick');
test('sort.13', $mortal, 'think sort(The quick Brown dog, i)', 'Brown dog quick The');
test('sort.14', $mortal, 'think sort(the quick brown dog, a)', 'brown dog quick the');
# Results may vary
#test('sort.15', $mortal, 'think sort(The quick Brown dog, a)', 'Brown dog quick The');

# Comp
test('comp.1', $mortal, 'think comp(9, 10)', '1');
test('comp.2', $mortal, 'think comp(9, 10, n)', '-1');
test('comp.3', $mortal, 'think comp(5, 5.0)', '-1');
test('comp.4', $mortal, 'think comp(5, 5.0, f)', '0');
test('comp.5', $mortal, 'think comp(#1, #2)', '-1');
test('comp.6', $mortal, 'think comp(#1, #2, d)', '-1');
test('comp.7', $mortal, 'think comp(dog, dOg, l)', '1');
test('comp.8', $mortal, 'think comp(dog, dOg, i)', '0');
# Results may vary
#test('comp.9', $mortal, 'think comp(dog, dOg, a)', '-1');
