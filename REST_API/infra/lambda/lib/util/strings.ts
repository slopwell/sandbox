import assert from "node:assert/strict";

declare type MaybeString = string | null | undefined;

export function strip(value: MaybeString): string {
  return (value ?? "").trim().replace(/^\u3000+|\u3000+$/, "");
}

export function chop(value: MaybeString): string {
  return (value ?? "").replace(/\s+$/, "").replace(/\u3000+$/, "");
}

export function isEmpty(value: MaybeString): boolean {
  return strip(value).length == 0;
}

export function isNotEmpty(value: MaybeString): value is string {
  return false == isEmpty(value);
}

export function coalesce(...values: MaybeString[]): string | null {
  assert(values.length > 0);
  return values.find((it) => it != null) ?? null;
}
