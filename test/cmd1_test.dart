import 'package:test/test.dart';
import "package:c/src/md.quote.dart";

void main(){
  group("\u001B[35m\n\t|> Quote", (){
    Quote qu = DoubleQuote();
    group("\n\t|> On DoubleQuote", (){
      testSetForQuote(qu, "char", "\"", "\"", true);
      testSetForQuote(qu, "char", "<", ">", false);
      testSetForQuote(qu, "char", "", "", false);
      testSetForQuote(qu, "char", "\"", "", false);
      testSetForQuote(qu, "char", "\"", ">", false);
      testSetForQuote(qu, "char", "", "\"", false);
    });
  });
}
void testSetForQuote(Quote q, String testStr, String starts, String ends, bool valid){
  group("\n\t|> ${valid ? "Valid" : "Invalid"} Test Case: Starts $starts and ends $ends", (){
    test("\n\t|> ${q.runtimeType}.cover()", (){
      expect(q.cover(testStr), equals("${q.starts}$testStr${q.ends}"));
    });
    test("\n\t|> ${q.runtimeType}.uncover()", (){
      expect(q.uncover("$starts$testStr$ends"), equals(valid ? testStr : "$starts$testStr$ends"));
    });
    test("\n\t|> ${q.runtimeType}.hasCoveringIn()", (){
      expect(q.hasCoveringIn("$starts$testStr$ends"), equals(valid));
    });
  });
}