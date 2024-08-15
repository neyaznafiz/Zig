const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const expect = std.testing.expect;
const print = std.debug.print;

pub fn main() void {
	foo();
}

fn foo() void {
	// It works at file scope as well as inside functions.
	var y: *const [5:0]u8 = undefined;
	const x = "World";

	// Once assigned, an identifier cannot be changed.
	y = x;

	print("{s}\n", .{y});
}

// test "expect addOne adds one to 41, the result will eb 42" {
	//try expect(addOne(41) == 42);
// }

// test addOne {
	//try expect(addOne(41) == 42);
// }

fn addOne(number:i8) i8 {
	return number + 1;
}

// test "this will be skipped" {
	// return error.SkipZigTest;
// }

// test "detect leak" {
	// var list = std.ArrayList(u21).init(std.testing.allocator);
	// missing `defer list.deinit();`
	// try list.append('☔');

	// try std.testing.expect(list.items.len == 1);
// }

// test "builtin.is_test" {
	//try expect(isATest());
// }

// fn isATest() bool {
	// return builtin.is_test;
// }

threadlocal var a: i32 = 1234;

test "thread local storage" {
	const thread1 = try std.Thread.spawn(.{}, testTls, .{});
	const thread2 = try std.Thread.spawn(.{}, testTls, .{});
	const thread3 = try std.Thread.spawn(.{}, testTls, .{});
	const thread4 = try std.Thread.spawn(.{}, testTls, .{});
	const thread5 = try std.Thread.spawn(.{}, testTls, .{});
	testTls();
	thread1.join();
	thread2.join();
	thread3.join();
	thread4.join();
	thread5.join();
}

fn testTls() void {
	assert(a == 1234);
	a += 1;
	assert(a == 1235);
	a += 1;
	assert(a == 1236);
	a += 1;
	assert(a == 1237);
	a += 1;
	assert(a == 1238);
}