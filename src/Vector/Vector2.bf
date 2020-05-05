/*
Copyright (c) 2006 - 2008 The Open Toolkit library.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */

using System;

namespace OpenToolkit.Mathematics
{
	[Ordered]
	public struct Vector2 : IEquatable<Vector2>, IHashable
	{
		/// <summary>
		/// The X component of the Vector2.
		/// </summary>
		public float X;

		/// <summary>
		/// The Y component of the Vector2.
		/// </summary>
		public float Y;

		/// <summary>
		/// Initializes a new instance of the <see cref="Vector2"/> struct.
		/// </summary>
		/// <param name="value">The value that will initialize this instance.</param>
		public this(float value)
		{
		    X = value;
		    Y = value;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Vector2"/> struct.
		/// </summary>
		/// <param name="x">The x coordinate of the net Vector2.</param>
		/// <param name="y">The y coordinate of the net Vector2.</param>
		public this(float x, float y)
		{
		    X = x;
		    Y = y;
		}

		/// <summary>
		/// Gets or sets the value at the index of the Vector.
		/// </summary>
		/// <param name="index">The index of the component from the Vector.</param>
		/// <exception cref="IndexOutOfRangeException">Thrown if the index is less than 0 or greater than 1.</exception>
		public float this[int index]
		{
			[Inline]
		    get
		    {
		        if (index == 0)
		        {
		            return X;
		        }

		        if (index == 1)
		        {
		            return Y;
		        }

				Internal.ThrowIndexOutOfRange(1);
		    }

			[Inline]
		    set	mut
		    {
		        if (index == 0)
		        {
		            X = value;
		        }
		        else if (index == 1)
		        {
		            Y = value;
		        }
		        else
		        {
					Internal.ThrowIndexOutOfRange(1);
		        }
		    }
		}

		/// <summary>
		/// Gets the length (magnitude) of the vector.
		/// </summary>
		/// <see cref="LengthFast"/>
		/// <seealso cref="LengthSquared"/>
		public float Length => (float)Math.Sqrt((X * X) + (Y * Y));

		/// <summary>
		/// Gets an approximation of the vector length (magnitude).
		/// </summary>
		/// <remarks>
		/// This property uses an approximation of the square root function to calculate vector magnitude, with
		/// an upper error bound of 0.001.
		/// </remarks>
		/// <see cref="Length"/>
		/// <seealso cref="LengthSquared"/>
		public float LengthFast => 1.0f / MathHelper.InverseSqrtFast((X * X) + (Y * Y));

		/// <summary>
		/// Gets the square of the vector length (magnitude).
		/// </summary>
		/// <remarks>
		/// This property avoids the costly square root operation required by the Length property. This makes it more suitable
		/// for comparisons.
		/// </remarks>
		/// <see cref="Length"/>
		/// <seealso cref="LengthFast"/>
		public float LengthSquared => (X * X) + (Y * Y);

		/// <summary>
		/// Gets the perpendicular vector on the right side of this vector.
		/// </summary>
		public Vector2 PerpendicularRight => Vector2(Y, -X);

		/// <summary>
		/// Gets the perpendicular vector on the left side of this vector.
		/// </summary>
		public Vector2 PerpendicularLeft => Vector2(-Y, X);

		/// <summary>
		/// Returns a copy of the Vector2 scaled to unit length.
		/// </summary>
		/// <returns>The normalized copy.</returns>
		public Vector2 Normalized()
		{
		    var v = this;
		    v.Normalize();
		    return v;
		}

		/// <summary>
		/// Scales the Vector2 to unit length.
		/// </summary>
		public void Normalize() mut
		{
		    var scale = 1.0f / Length;
		    X *= scale;
		    Y *= scale;
		}

		/// <summary>
		/// Scales the Vector2 to approximately unit length.
		/// </summary>
		public void NormalizeFast() mut
		{
		    var scale = MathHelper.InverseSqrtFast((X * X) + (Y * Y));
		    X *= scale;
		    Y *= scale;
		}

		/// <summary>
		/// Defines a unit-length Vector2 that points towards the X-axis.
		/// </summary>
		public static readonly Vector2 UnitX = Vector2(1, 0);

		/// <summary>
		/// Defines a unit-length Vector2 that points towards the Y-axis.
		/// </summary>
		public static readonly Vector2 UnitY = Vector2(0, 1);

		/// <summary>
		/// Defines a zero-length Vector2.
		/// </summary>
		public static readonly Vector2 Zero = Vector2(0, 0);

		/// <summary>
		/// Defines an instance with all components set to 1.
		/// </summary>
		public static readonly Vector2 One = Vector2(1, 1);

		/// <summary>
		/// Defines an instance with all components set to positive infinity.
		/// </summary>
		public static readonly Vector2 PositiveInfinity = Vector2(float.PositiveInfinity, float.PositiveInfinity);

		/// <summary>
		/// Defines an instance with all components set to negative infinity.
		/// </summary>
		public static readonly Vector2 NegativeInfinity = Vector2(float.NegativeInfinity, float.NegativeInfinity);

		/// <summary>
		/// Adds two vectors.
		/// </summary>
		/// <param name="a">Left operand.</param>
		/// <param name="b">Right operand.</param>
		/// <returns>Result of operation.</returns>
		public static Vector2 Add(Vector2 a, Vector2 b)
		{
			var _a = a;
			var _b = b;
		    Add(ref _a, ref _b, out _a);
		    return _a;
		}

		/// <summary>
		/// Adds two vectors.
		/// </summary>
		/// <param name="a">Left operand.</param>
		/// <param name="b">Right operand.</param>
		/// <param name="result">Result of operation.</param>
		public static void Add(ref Vector2 a, ref Vector2 b, out Vector2 result)
		{
		    result.X = a.X + b.X;
		    result.Y = a.Y + b.Y;
		}

        /// <summary>
        /// Subtract one Vector from another.
        /// </summary>
        /// <param name="a">First operand.</param>
        /// <param name="b">Second operand.</param>
        /// <returns>Result of subtraction.</returns>
        public static Vector2 Subtract(Vector2 a, Vector2 b)
        {
			var _a = a;
			var _b = b;
            Subtract(ref _a, ref _b, out _a);
            return _a;
        }

        /// <summary>
        /// Subtract one Vector from another.
        /// </summary>
        /// <param name="a">First operand.</param>
        /// <param name="b">Second operand.</param>
        /// <param name="result">Result of subtraction.</param>
        public static void Subtract(ref Vector2 a, ref Vector2 b, out Vector2 result)
        {
            result.X = a.X - b.X;
            result.Y = a.Y - b.Y;
        }
		
		/// <summary>
		/// Multiplies a vector by a scalar.
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <returns>Result of the operation.</returns>
		public static Vector2 Multiply(Vector2 vector, float scale)
		{
			var v = vector;
		    Multiply(ref v, scale, out v);
		    return v;
		}

		/// <summary>
		/// Multiplies a vector by a scalar.
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <param name="result">Result of the operation.</param>
		public static void Multiply(ref Vector2 vector, float scale, out Vector2 result)
		{
		    result.X = vector.X * scale;
		    result.Y = vector.Y * scale;
		}
		
		/// <summary>
		/// Multiplies a vector by the components a vector (scale).
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <returns>Result of the operation.</returns>
		public static Vector2 Multiply(Vector2 vector, Vector2 scale)
		{
			var v = vector;
			var s = scale;
		    Multiply(ref v, ref s, out v);
		    return v;
		}

		/// <summary>
		/// Multiplies a vector by the components of a vector (scale).
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <param name="result">Result of the operation.</param>
		public static void Multiply(ref Vector2 vector, ref Vector2 scale, out Vector2 result)
		{
		    result.X = vector.X * scale.X;
		    result.Y = vector.Y * scale.Y;
		}
		
		/// <summary>
		/// Divides a vector by a scalar.
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <returns>Result of the operation.</returns>
		public static Vector2 Divide(Vector2 vector, float scale)
		{
			var v = vector;
		    Divide(ref v, scale, out v);
		    return v;
		}

		/// <summary>
		/// Divides a vector by a scalar.
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <param name="result">Result of the operation.</param>
		public static void Divide(ref Vector2 vector, float scale, out Vector2 result)
		{
		    result.X = vector.X / scale;
		    result.Y = vector.Y / scale;
		}
		
		/// <summary>
		/// Divides a vector by the components of a vector (scale).
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <returns>Result of the operation.</returns>
		public static Vector2 Divide(Vector2 vector, Vector2 scale)
		{
			var v = vector;
			var s = scale;
		    Divide(ref v, ref s, out v);
		    return v;
		}

		/// <summary>
		/// Divide a vector by the components of a vector (scale).
		/// </summary>
		/// <param name="vector">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <param name="result">Result of the operation.</param>
		public static void Divide(ref Vector2 vector, ref Vector2 scale, out Vector2 result)
		{
		    result.X = vector.X / scale.X;
		    result.Y = vector.Y / scale.Y;
		}
		
		/// <summary>
		/// Returns a vector created from the smallest of the corresponding components of the given vectors.
		/// </summary>
		/// <param name="a">First operand.</param>
		/// <param name="b">Second operand.</param>
		/// <returns>The component-wise minimum.</returns>
		public static Vector2 ComponentMin(Vector2 a, Vector2 b)
		{
		    return Vector2(a.X < b.X ? a.X : b.X, a.Y < b.Y ? a.Y : b.Y);
		}

		/// <summary>
		/// Returns a vector created from the smallest of the corresponding components of the given vectors.
		/// </summary>
		/// <param name="a">First operand.</param>
		/// <param name="b">Second operand.</param>
		/// <param name="result">The component-wise minimum.</param>
		public static void ComponentMin(ref Vector2 a, ref Vector2 b, out Vector2 result)
		{
		    result.X = a.X < b.X ? a.X : b.X;
		    result.Y = a.Y < b.Y ? a.Y : b.Y;
		}
		
		/// <summary>
		/// Returns a vector created from the largest of the corresponding components of the given vectors.
		/// </summary>
		/// <param name="a">First operand.</param>
		/// <param name="b">Second operand.</param>
		/// <returns>The component-wise maximum.</returns>
		public static Vector2 ComponentMax(Vector2 a, Vector2 b)
		{
		    return Vector2(a.X > b.X ? a.X : b.X, a.Y > b.Y ? a.Y : b.Y);
		}

		/// <summary>
		/// Returns a vector created from the largest of the corresponding components of the given vectors.
		/// </summary>
		/// <param name="a">First operand.</param>
		/// <param name="b">Second operand.</param>
		/// <param name="result">The component-wise maximum.</param>
		public static void ComponentMax(ref Vector2 a, ref Vector2 b, out Vector2 result)
		{
		    result.X = a.X > b.X ? a.X : b.X;
		    result.Y = a.Y > b.Y ? a.Y : b.Y;
		}

		/// <summary>
		/// Returns the Vector2 with the minimum magnitude. If the magnitudes are equal, the second vector
		/// is selected.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <returns>The minimum Vector2.</returns>
		public static Vector2 MagnitudeMin(Vector2 left, Vector2 right)
		{
		    return left.LengthSquared < right.LengthSquared ? left : right;
		}

		/// <summary>
		/// Returns the Vector2 with the minimum magnitude. If the magnitudes are equal, the second vector
		/// is selected.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <param name="result">The magnitude-wise minimum.</param>
		public static void MagnitudeMin(ref Vector2 left, ref Vector2 right, out Vector2 result)
		{
		    result = left.LengthSquared < right.LengthSquared ? left : right;
		}
		
		/// <summary>
		/// Returns the Vector2 with the maximum magnitude. If the magnitudes are equal, the first vector
		/// is selected.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <returns>The maximum Vector2.</returns>
		public static Vector2 MagnitudeMax(Vector2 left, Vector2 right)
		{
		    return left.LengthSquared >= right.LengthSquared ? left : right;
		}

		/// <summary>
		/// Returns the Vector2 with the maximum magnitude. If the magnitudes are equal, the first vector
		/// is selected.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <param name="result">The magnitude-wise maximum.</param>
		public static void MagnitudeMax(ref Vector2 left, ref Vector2 right, out Vector2 result)
		{
		    result = left.LengthSquared >= right.LengthSquared ? left : right;
		}
		/// <summary>
		/// Clamp a vector to the given minimum and maximum vectors.
		/// </summary>
		/// <param name="vec">Input vector.</param>
		/// <param name="min">Minimum vector.</param>
		/// <param name="max">Maximum vector.</param>
		/// <returns>The clamped vector.</returns>
		public static Vector2 Clamp(Vector2 vec, Vector2 min, Vector2 max)
		{
		    return Vector2(
				vec.X < min.X ? min.X : vec.X > max.X ? max.X : vec.X,
				vec.Y < min.Y ? min.Y : vec.Y > max.Y ? max.Y : vec.Y
			);
		}

		/// <summary>
		/// Clamp a vector to the given minimum and maximum vectors.
		/// </summary>
		/// <param name="vec">Input vector.</param>
		/// <param name="min">Minimum vector.</param>
		/// <param name="max">Maximum vector.</param>
		/// <param name="result">The clamped vector.</param>
		public static void Clamp(ref Vector2 vec, ref Vector2 min, ref Vector2 max, out Vector2 result)
		{
		    result.X = vec.X < min.X ? min.X : vec.X > max.X ? max.X : vec.X;
		    result.Y = vec.Y < min.Y ? min.Y : vec.Y > max.Y ? max.Y : vec.Y;
		}

		/// <summary>
		/// Compute the euclidean distance between two vectors.
		/// </summary>
		/// <param name="vec1">The first vector.</param>
		/// <param name="vec2">The second vector.</param>
		/// <returns>The distance.</returns>
		public static float Distance(Vector2 vec1, Vector2 vec2)
		{
			var v1 = vec1;
			var v2 = vec2;
			float result;
		    Distance(ref v1, ref v2, out result);
		    return result;
		}

		/// <summary>
		/// Compute the euclidean distance between two vectors.
		/// </summary>
		/// <param name="vec1">The first vector.</param>
		/// <param name="vec2">The second vector.</param>
		/// <param name="result">The distance.</param>
		public static void Distance(ref Vector2 vec1, ref Vector2 vec2, out float result)
		{
		    result = (float)Math.Sqrt(((vec2.X - vec1.X) * (vec2.X - vec1.X)) + ((vec2.Y - vec1.Y) * (vec2.Y - vec1.Y)));
		}

        /// <summary>
        /// Compute the squared euclidean distance between two vectors.
        /// </summary>
        /// <param name="vec1">The first vector.</param>
        /// <param name="vec2">The second vector.</param>
        /// <returns>The squared distance.</returns>
        public static float DistanceSquared(Vector2 vec1, Vector2 vec2)
        {
			var v1 = vec1;
			var v2 = vec2;
			float result;
            DistanceSquared(ref v1, ref v2, out result);
            return result;
        }

        /// <summary>
        /// Compute the squared euclidean distance between two vectors.
        /// </summary>
        /// <param name="vec1">The first vector.</param>
        /// <param name="vec2">The second vector.</param>
        /// <param name="result">The squared distance.</param>
        public static void DistanceSquared(ref Vector2 vec1, ref Vector2 vec2, out float result)
        {
            result = ((vec2.X - vec1.X) * (vec2.X - vec1.X)) + ((vec2.Y - vec1.Y) * (vec2.Y - vec1.Y));
        }

		/// <summary>
		/// Scale a vector to unit length.
		/// </summary>
		/// <param name="vec">The input vector.</param>
		/// <returns>The normalized copy.</returns>
		public static Vector2 Normalize(Vector2 vec)
		{
			var v = vec;
		    var scale = 1.0f / v.Length;
		    return Vector2(v.X * scale, v.Y * scale);
		}

		/// <summary>
		/// Scale a vector to unit length.
		/// </summary>
		/// <param name="vec">The input vector.</param>
		/// <param name="result">The normalized vector.</param>
		public static void Normalize(ref Vector2 vec, out Vector2 result)
		{
		    var scale = 1.0f / vec.Length;
		    result.X = vec.X * scale;
		    result.Y = vec.Y * scale;
		}

		/// <summary>
		/// Scale a vector to approximately unit length.
		/// </summary>
		/// <param name="vec">The input vector.</param>
		/// <returns>The normalized copy.</returns>
		public static Vector2 NormalizeFast(Vector2 vec)
		{
		    var scale = MathHelper.InverseSqrtFast((vec.X * vec.X) + (vec.Y * vec.Y));
		    return Vector2(vec.X * scale, vec.Y * scale);
		}

		/// <summary>
		/// Scale a vector to approximately unit length.
		/// </summary>
		/// <param name="vec">The input vector.</param>
		/// <param name="result">The normalized vector.</param>
		public static void NormalizeFast(ref Vector2 vec, out Vector2 result)
		{
		    var scale = MathHelper.InverseSqrtFast((vec.X * vec.X) + (vec.Y * vec.Y));
		    result.X = vec.X * scale;
		    result.Y = vec.Y * scale;
		}

		/// <summary>
		/// Calculate the dot (scalar) product of two vectors.
		/// </summary>
		/// <param name="left">First operand.</param>
		/// <param name="right">Second operand.</param>
		/// <returns>The dot product of the two inputs.</returns>
		public static float Dot(Vector2 left, Vector2 right)
		{
		    return (left.X * right.X) + (left.Y * right.Y);
		}

		/// <summary>
		/// Calculate the dot (scalar) product of two vectors.
		/// </summary>
		/// <param name="left">First operand.</param>
		/// <param name="right">Second operand.</param>
		/// <param name="result">The dot product of the two inputs.</param>
		public static void Dot(ref Vector2 left, ref Vector2 right, out float result)
		{
		    result = (left.X * right.X) + (left.Y * right.Y);
		}
		
		/// <summary>
		/// Calculate the perpendicular dot (scalar) product of two vectors.
		/// </summary>
		/// <param name="left">First operand.</param>
		/// <param name="right">Second operand.</param>
		/// <returns>The perpendicular dot product of the two inputs.</returns>
		public static float PerpDot(Vector2 left, Vector2 right)
		{
		    return (left.X * right.Y) - (left.Y * right.X);
		}

		/// <summary>
		/// Calculate the perpendicular dot (scalar) product of two vectors.
		/// </summary>
		/// <param name="left">First operand.</param>
		/// <param name="right">Second operand.</param>
		/// <param name="result">The perpendicular dot product of the two inputs.</param>
		public static void PerpDot(ref Vector2 left, ref Vector2 right, out float result)
		{
		    result = (left.X * right.Y) - (left.Y * right.X);
		}
		
		/// <summary>
		/// Returns a new Vector that is the linear blend of the 2 given Vectors.
		/// </summary>
		/// <param name="a">First input vector.</param>
		/// <param name="b">Second input vector.</param>
		/// <param name="blend">The blend factor. a when blend=0, b when blend=1.</param>
		/// <returns>a when blend=0, b when blend=1, and a linear combination otherwise.</returns>
		public static Vector2 Lerp(Vector2 a, Vector2 b, float blend)
		{
		    return Vector2(
				(blend * (b.X - a.X)) + a.X,
				(blend * (b.Y - a.Y)) + a.Y
			);
		}

		/// <summary>
		/// Returns a new Vector that is the linear blend of the 2 given Vectors.
		/// </summary>
		/// <param name="a">First input vector.</param>
		/// <param name="b">Second input vector.</param>
		/// <param name="blend">The blend factor. a when blend=0, b when blend=1.</param>
		/// <param name="result">a when blend=0, b when blend=1, and a linear combination otherwise.</param>
		public static void Lerp(ref Vector2 a, ref Vector2 b, float blend, out Vector2 result)
		{
		    result.X = (blend * (b.X - a.X)) + a.X;
		    result.Y = (blend * (b.Y - a.Y)) + a.Y;
		}

		/// <summary>
		/// Interpolate 3 Vectors using Barycentric coordinates.
		/// </summary>
		/// <param name="a">First input Vector.</param>
		/// <param name="b">Second input Vector.</param>
		/// <param name="c">Third input Vector.</param>
		/// <param name="u">First Barycentric Coordinate.</param>
		/// <param name="v">Second Barycentric Coordinate.</param>
		/// <returns>a when u=v=0, b when u=1,v=0, c when u=0,v=1, and a linear combination of a,b,c otherwise.</returns>
		public static Vector2 BaryCentric(Vector2 a, Vector2 b, Vector2 c, float u, float v)
		{
			var _a = a;
			var _b = b;
			var _c = c;
			Vector2 result;
		    BaryCentric(ref _a, ref _b, ref _c, u, v, out result);
		    return result;
		}

		/// <summary>
		/// Interpolate 3 Vectors using Barycentric coordinates.
		/// </summary>
		/// <param name="a">First input Vector.</param>
		/// <param name="b">Second input Vector.</param>
		/// <param name="c">Third input Vector.</param>
		/// <param name="u">First Barycentric Coordinate.</param>
		/// <param name="v">Second Barycentric Coordinate.</param>
		/// <param name="result">
		/// Output Vector. a when u=v=0, b when u=1,v=0, c when u=0,v=1, and a linear combination of a,b,c
		/// otherwise.
		/// </param>
		public static void BaryCentric
		(
		    ref Vector2 a,
		    ref Vector2 b,
		    ref Vector2 c,
		    float u,
		    float v,
		    out Vector2 result
		)
		{
		    result = a; // copy

		    var temp = b; // copy
		    Subtract(ref temp, ref a, out temp);
		    Multiply(ref temp, u, out temp);
		    Add(ref result, ref temp, out result);

		    temp = c; // copy
		    Subtract(ref temp, ref a, out temp);
		    Multiply(ref temp, v, out temp);
		    Add(ref result, ref temp, out result);
		}

		/// <summary>
		/// Transform a Vector by the given Matrix.
		/// </summary>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="mat">The desired transformation.</param>
		/// <returns>The transformed vector.</returns>
		public static Vector2 Transform(Vector2 vec, Matrix2 mat)
		{
			var _vec = vec;
			var _mat = mat;
			Vector2 result;
		    Transform(ref _vec, ref _mat, out result);
		    return result;
		}

		/// <summary>
		/// Transform a Vector by the given Matrix.
		/// </summary>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="mat">The desired transformation.</param>
		/// <param name="result">The transformed vector.</param>
		public static void Transform(ref Vector2 vec, ref Matrix2 mat, out Vector2 result)
		{
		    result = Vector2(
		        (vec.X * mat.Row0.X) + (vec.Y * mat.Row1.X),
		        (vec.X * mat.Row0.Y) + (vec.Y * mat.Row1.Y));
		}
		

		/// <summary>
		/// Transforms a vector by a quaternion rotation.
		/// </summary>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="quat">The quaternion to rotate the vector by.</param>
		/// <returns>The result of the operation.</returns>
		public static Vector2 Transform(Vector2 vec, Quaternion quat)
		{ 
			var _vec = vec;
			var _quat = quat;
			Vector2 result;
		    Transform(ref _vec, ref _quat, out result);
		    return result;
		}

		/// <summary>
		/// Transforms a vector by a quaternion rotation.
		/// </summary>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="quat">The quaternion to rotate the vector by.</param>
		/// <param name="result">The result of the operation.</param>
		public static void Transform(ref Vector2 vec, ref Quaternion quat, out Vector2 result)
		{
		    Quaternion v = Quaternion(vec.X, vec.Y, 0, 0);
			Quaternion i;
			Quaternion t;
		    Quaternion.Invert(ref quat, out i);
		    Quaternion.Multiply(ref quat, ref v, out t);
		    Quaternion.Multiply(ref t, ref i, out v);

		    result.X = v.X;
		    result.Y = v.Y;
		}

		/// <summary>
		/// Transform a Vector by the given Matrix using right-handed notation.
		/// </summary>
		/// <param name="mat">The desired transformation.</param>
		/// <param name="vec">The vector to transform.</param>
		/// <returns>The transformed vector.</returns>
		public static Vector2 Transform(Matrix2 mat, Vector2 vec)
		{
			var _mat = mat;
			var _vec = vec;
			Vector2 result;
		    Transform(ref _mat, ref _vec, out result);
		    return result;
		}

		/// <summary>
		/// Transform a Vector by the given Matrix using right-handed notation.
		/// </summary>
		/// <param name="mat">The desired transformation.</param>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="result">The transformed vector.</param>
		public static void Transform(ref Matrix2 mat, ref Vector2 vec, out Vector2 result)
		{
		    result.X = (mat.Row0.X * vec.X) + (mat.Row0.Y * vec.Y);
		    result.Y = (mat.Row1.X * vec.X) + (mat.Row1.Y * vec.Y);
		}

		/// <summary>
		/// Gets or sets an OpenToolkit.Vector2 with the Y and X components of this instance.
		/// </summary>
		public Vector2 Yx
		{
		    get{ return Vector2(Y, X); }
		    set	mut
		    {
		        Y = value.X;
		        X = value.Y;
		    }
		}

		/// <summary>
		/// Adds the specified instances.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <returns>Result of addition.</returns>
		public static Vector2 operator +(Vector2 left, Vector2 right)
		{
		    return Vector2(left.X + right.X, left.Y + right.Y);
		}

		/// <summary>
		/// Subtracts the specified instances.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <returns>Result of subtraction.</returns>
		public static Vector2 operator -(Vector2 left, Vector2 right)
		{
		    return Vector2(left.X - right.X, left.Y - right.Y);
		}

		/// <summary>
		/// Negates the specified instance.
		/// </summary>
		/// <param name="vec">Operand.</param>
		/// <returns>Result of negation.</returns>
		public static Vector2 operator -(Vector2 vec)
		{
		    return Vector2(-vec.X, -vec.Y);
		}

		/// <summary>
		/// Multiplies the specified instance by a scalar.
		/// </summary>
		/// <param name="vec">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <returns>Result of multiplication.</returns>
		public static Vector2 operator *(Vector2 vec, float scale)
		{
		    return Vector2(vec.X * scale, vec.Y * scale);
		}

		/// <summary>
		/// Multiplies the specified instance by a scalar.
		/// </summary>
		/// <param name="scale">Left operand.</param>
		/// <param name="vec">Right operand.</param>
		/// <returns>Result of multiplication.</returns>
		public static Vector2 operator *(float scale, Vector2 vec)
		{
		    return Vector2(vec.X * scale, vec.Y * scale);
		}

		/// <summary>
		/// Component-wise multiplication between the specified instance by a scale vector.
		/// </summary>
		/// <param name="scale">Left operand.</param>
		/// <param name="vec">Right operand.</param>
		/// <returns>Result of multiplication.</returns>
		public static Vector2 operator *(Vector2 vec, Vector2 scale)
		{
		    return Vector2(vec.X * scale.X, vec.Y * scale.Y);
		}

		/// <summary>
		/// Transform a Vector by the given Matrix.
		/// </summary>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="mat">The desired transformation.</param>
		/// <returns>The transformed vector.</returns>
		public static Vector2 operator *(Vector2 vec, Matrix2 mat)
		{
			var _vec = vec;
			var _mat = mat;
			Vector2 result;
		    Transform(ref _vec, ref _mat, out result);
		    return result;
		}

		/// <summary>
		/// Transform a Vector by the given Matrix using right-handed notation.
		/// </summary>
		/// <param name="mat">The desired transformation.</param>
		/// <param name="vec">The vector to transform.</param>
		/// <returns>The transformed vector.</returns>
		public static Vector2 operator *(Matrix2 mat, Vector2 vec)
		{
			var _vec = vec;
			var _mat = mat;
			Vector2 result;
		    Transform(ref _mat, ref _vec, out result);
		    return result;
		}

		/// <summary>
		/// Transforms a vector by a quaternion rotation.
		/// </summary>
		/// <param name="vec">The vector to transform.</param>
		/// <param name="quat">The quaternion to rotate the vector by.</param>
		/// <returns>The multiplied vector.</returns>
		public static Vector2 operator *(Quaternion quat, Vector2 vec)
		{ 	 
			var _vec = vec;
			var _quat = quat;
			Vector2 result;
		    Transform(ref _vec, ref _quat, out result);
		    return result;
		}

		/// <summary>
		/// Divides the specified instance by a scalar.
		/// </summary>
		/// <param name="vec">Left operand.</param>
		/// <param name="scale">Right operand.</param>
		/// <returns>Result of the division.</returns>
		public static Vector2 operator /(Vector2 vec, float scale)
		{
		    return Vector2(vec.X / scale, vec.Y / scale);
		}

		/// <summary>
		/// Compares the specified instances for equality.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <returns>True if both instances are equal; false otherwise.</returns>
		public static bool operator ==(Vector2 left, Vector2 right)
		{
		    return left.Equals(right);
		}

		/// <summary>
		/// Compares the specified instances for inequality.
		/// </summary>
		/// <param name="left">Left operand.</param>
		/// <param name="right">Right operand.</param>
		/// <returns>True if both instances are not equal; false otherwise.</returns>
		public static bool operator !=(Vector2 left, Vector2 right)
		{
		    return !left.Equals(right);
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="Vector2"/> struct using a tuple containing the component
		/// values.
		/// </summary>
		/// <param name="values">A tuple containing the component values.</param>
		/// <returns>A new instance of the <see cref="Vector2"/> struct with the given component values.</returns>
		public static implicit operator Vector2((float X, float Y) values)
		{
		    return Vector2(values.X, values.Y);
		}

		/// <inheritdoc/>
		public void ToString(String strBuffer)
		{
			strBuffer.Append("(");
			X.ToString(strBuffer);
			strBuffer.Append("; ");
			Y.ToString(strBuffer);
			strBuffer.Append(")");
		}

		/// <summary>
		/// Returns the hashcode for this instance.
		/// </summary>
		/// <returns>A System.Int32 containing the unique hashcode for this instance.</returns>
		public int GetHashCode()
		{
		    unchecked
		    {
		        return (X.GetHashCode() * 397) ^ Y.GetHashCode();
		    }
		}

		/// <summary>
		/// Indicates whether this instance and a specified object are equal.
		/// </summary>
		/// <param name="obj">The object to compare to.</param>
		/// <returns>True if the instances are equal; false otherwise.</returns>
		public bool Equals(Object obj)
		{
		    if (!(obj is Vector2))
		    {
		        return false;
		    }

		    return Equals((Vector2)obj);
		}

		/// <summary>
		/// Indicates whether the current vector is equal to another vector.
		/// </summary>
		/// <param name="other">A vector to compare with this vector.</param>
		/// <returns>true if the current vector is equal to the vector parameter; otherwise, false.</returns>
		public bool Equals(Vector2 other)
		{
		    return
		        X == other.X &&
		        Y == other.Y;
		}
	}
}
