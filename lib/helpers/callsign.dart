/// HamCore callsign helpers.
///
/// HamCore firmware requires every node name to begin with a valid US amateur
/// callsign (FCC Part 97.119): a 1-2 letter prefix (K/N/W, or AA-AL, KA-KZ,
/// NA-NZ, WA-WZ), one digit, and a 1-3 letter suffix — optionally followed by
/// '-' or ' ' and an SSID/description (e.g. "W1AW", "W1AW-2", "KD2ABC Base").
library;

final RegExp _callsignPattern = RegExp(
  r'^(A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3}$',
);

/// True when [name] begins with a valid US amateur callsign.
bool isValidCallsignName(String name) {
  final sep = name.indexOf(RegExp(r'[- ]'));
  final call = (sep < 0 ? name : name.substring(0, sep)).toUpperCase();
  return _callsignPattern.hasMatch(call);
}

/// True when [mhz] is inside a US amateur band HamCore supports
/// (70cm: 420-450 MHz, 33cm: 902-928 MHz).
bool isHamFrequencyMHz(double mhz) =>
    (mhz >= 420.0 && mhz <= 450.0) || (mhz >= 902.0 && mhz <= 928.0);
