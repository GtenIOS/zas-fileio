const std = @import("std");
pub inline fn readFile(allocator: std.mem.Allocator, file_name: []const u8) ![]u8 {
    return try std.fs.cwd().readFileAlloc(allocator, file_name, std.math.maxInt(usize));
}

pub inline fn readFileToLines(allocator: std.mem.Allocator, file_name: []const u8, array: *std.ArrayList([]const u8)) !void {
    const file = try std.fs.cwd().openFile(file_name, .{});
    while (file.reader().readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize))) |line| {
        if (line) |value| {
            try array.append(value);
        } else {
            break;
        }
    } else |err| {
        return err;
    }

    file.close();
}

pub inline fn writeBytesToFile(bytes: []const u8, file_name: []const u8) !void {
    const file = try std.fs.cwd().createFile(file_name, .{ .truncate = false });
    try file.writer().writeAll(bytes);
    
    file.close();
}
