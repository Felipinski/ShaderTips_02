//This function receive 2 colors by parameter and returns a final color
float4 MultiplyColor(float4 originalColor, float4 colorToMultiply)
{
	return originalColor * colorToMultiply;
}

//This function receive 2 colors.. the inout paremeter is a direct reference to the value passed.
//Any change made in this function affects the original value passed
void MultiplyColorRef(inout float4 originalColor, float4 colorToMultiply)
{
	originalColor *= colorToMultiply;
}