const std = @import("std");

pub fn main() !void {
    // Initialize handles for standard input and output
    const standard_output = std.io.getStdOut();
    var buffered_output_writer = std.io.bufferedWriter(standard_output.writer());
    const output_writer = buffered_output_writer.writer();

    const standard_input = std.io.getStdIn();
    var buffered_input_reader = std.io.bufferedReader(standard_input.reader());
    var input_reader = buffered_input_reader.reader();

    // Prompt the user for input
    try output_writer.print("What is your name?: ", .{});
    try buffered_output_writer.flush(); // Ensure prompt is visible immediately

    // Prepare a buffer for user input
    var user_input_buffer: [64]u8 = undefined;

    // Read user input until newline or end of input
    const optional_user_input = try input_reader.readUntilDelimiterOrEof(&user_input_buffer, '\n');

    if (optional_user_input) |raw_user_input| {
        // Trim any trailing carriage return or newline characters
        const trimmed_user_input = std.mem.trim(u8, raw_user_input, "\r\n");

        // Print a personalized greeting
        try output_writer.print("Hello, {s}!\n", .{trimmed_user_input});
    } else {
        // Handle cases where no input was provided
        try output_writer.print("No input provided. Please try again.\n", .{});
    }

    // Ensure all buffered output is flushed to the terminal
    try buffered_output_writer.flush();
}
