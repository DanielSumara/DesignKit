#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log="${1:-${TMPDIR:-/tmp}/designkit-gate.log}"
step_log="$(mktemp)"
trap 'rm -f "$step_log"' EXIT
: > "$log"

for tool in swiftlint xcodegen xcodebuild xcrun; do
    if ! command -v "$tool" > /dev/null 2>&1; then
        echo "0 tools: fail (missing $tool)"
        echo "log: $log"
        exit 1
    fi
done
echo "0 tools: pass"

run_step() {
    local name="$1"
    shift
    echo "== $name: $*" >> "$log"
    "$@" > "$step_log" 2>&1
    local status=$?
    cat "$step_log" >> "$log"
    if [ "$status" -eq 0 ]; then
        echo "$name: pass"
        return 0
    fi
    echo "$name: fail"
    grep -F "error:" "$step_log" | head -n 20
    echo "log: $log"
    exit 1
}

cd "$root" || exit 1
run_step "1 lint" swiftlint lint --strict --quiet
run_step "2 build package" xcrun swift build --build-system swiftbuild -Xswiftc -warnings-as-errors
run_step "3 build iOS" xcodebuild -scheme DesignSystem -destination 'generic/platform=iOS' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES

cd "$root/DemoApps" || exit 1
run_step "4 xcodegen" xcodegen generate
run_step "5a build ShowcasePhone" xcodebuild -project Showcase.xcodeproj -scheme ShowcasePhone -destination 'generic/platform=iOS Simulator' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES
run_step "5b build ShowcasePad" xcodebuild -project Showcase.xcodeproj -scheme ShowcasePad -destination 'generic/platform=iOS Simulator' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES
run_step "5c build ShowcaseMac" xcodebuild -project Showcase.xcodeproj -scheme ShowcaseMac -destination 'platform=macOS' build SWIFT_TREAT_WARNINGS_AS_ERRORS=YES
echo "log: $log"
