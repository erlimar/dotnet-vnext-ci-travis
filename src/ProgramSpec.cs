using System;
using Xunit;

public class ProgramSpecs
{
    [Fact]
    public void TestVoid()
    {
        var a = 1;
	var b = 2;
	Assert.NotEqual(a, b);
    }
}
