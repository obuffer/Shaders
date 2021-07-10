We have some rules for naming URP.

These rule follow the standard Core RP Library.

For space variable name suffix:

+ OS: object space
+ WS: world space
+ VS: view space
+ CS: Homogenous clip space
+ TS: Tangent space
+ TXS: Texture space

Example: PositionWS

We use the prefix "un" to label a vector that is not normalized.

For regular vector,we use captial letter,vector are always pointing outward the current pixel position.

+ V: View vector
+ L: Light vector
+ N: Normal vector
+ H: Half vector

Input/Ouputs structs:

+ Input: struct Attributes
+ Output: struct Varyings

