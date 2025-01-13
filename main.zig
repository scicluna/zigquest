const std = @import("std");

pub fn main() !void {
    var input: [80]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Enter something", .{});

    _ = try stdin.readUntilDelimiter(&input, '\n');

    try stdout.print("The user entered: {s}!\n", .{input});
}