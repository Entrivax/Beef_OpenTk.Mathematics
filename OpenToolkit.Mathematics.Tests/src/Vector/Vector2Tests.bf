using System;
using System.Reflection;
using OpenToolkit.Mathematics;
namespace OpenTk_Math_Tests.Vector
{
	class Vector2Tests
	{
		[Test]
		public static void MustInitializeWithOneParam()
		{
			Vector2 v = Vector2(1);
			Runtime.Assert(v.X == 1);
			Runtime.Assert(v.Y == 1);
		}

		[Test]
		public static void MustInitializeWithTwoParams()
		{
			Vector2 v = Vector2(1, 2);
			Runtime.Assert(v.X == 1);
			Runtime.Assert(v.Y == 2);
		}

		[Test]
		public static void MustReturnValuesPerIndex()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			Runtime.Assert(v[0] == x);
			Runtime.Assert(v[1] == y);
		}

		[Test]
		public static void Length_MustReturnVectorLength()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			Runtime.Assert(v.Length == (float)Math.Sqrt((x * x) + (y * y)));
		}

		[Test]
		public static void LengthSquared_MustReturnVectorSquareOfTheLength()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			Runtime.Assert(v.LengthSquared == ((x * x) + (y * y)));
		}

		[Test]
		public static void PerpendicularRight_MustReturnNewVectorPerpendicularRight()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			Vector2 v2 = v.PerpendicularRight;
			Runtime.Assert(v2.X == y);
			Runtime.Assert(v2.Y == -x);
		}

		[Test]
		public static void PerpendicularLeft_MustReturnNewVectorPerpendicularLeft()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			Vector2 v2 = v.PerpendicularLeft;
			Runtime.Assert(v2.X == -y);
			Runtime.Assert(v2.Y == x);
		}

		[Test]
		public static void Normalized_MustReturnNewVectorNormalized()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			let vLength = v.Length;
			Vector2 v2 = v.Normalized();
			Runtime.Assert(v2.X == x / vLength);
			Runtime.Assert(v2.Y == y / vLength);
			Runtime.Assert(v2.Length == 1);
			Runtime.Assert(v.X == x);
			Runtime.Assert(v.Y == y);
		}

		[Test]
		public static void Normalize_MustNormalizeTheVector()
		{
			let x = 3;
			let y = 5;
			Vector2 v = Vector2(x, y);
			let vLength = v.Length;
			v.Normalize();
			Runtime.Assert(v.X == x / vLength);
			Runtime.Assert(v.Y == y / vLength);
			Runtime.Assert(v.Length == 1);
		}

		[Test]
		public static void UnitX_MustReturnVectorOfUnitLengthOnX()
		{
			Vector2 v = Vector2.UnitX;
			Runtime.Assert(v.X == 1);
			Runtime.Assert(v.Y == 0);
		}

		[Test]
		public static void UnitY_MustReturnVectorOfUnitLengthOnY()
		{
			Vector2 v = Vector2.UnitY;
			Runtime.Assert(v.X == 0);
			Runtime.Assert(v.Y == 1);
		}

		[Test]
		public static void Zero_MustReturnVectorOfLengthZero()
		{
			Vector2 v = Vector2.Zero;
			Runtime.Assert(v.X == 0);
			Runtime.Assert(v.Y == 0);
		}

		[Test]
		public static void PositiveInfinity_MustReturnPositiveInfinityVector()
		{
			Vector2 v = Vector2.PositiveInfinity;
			Runtime.Assert(v.X == float.PositiveInfinity);
			Runtime.Assert(v.Y == float.PositiveInfinity);
		}

		[Test]
		public static void NegativeInfinity_MustReturnNegativeInfinityVector()
		{
			Vector2 v = Vector2.NegativeInfinity;
			Runtime.Assert(v.X == float.NegativeInfinity);
			Runtime.Assert(v.Y == float.NegativeInfinity);
		}
	}
}
