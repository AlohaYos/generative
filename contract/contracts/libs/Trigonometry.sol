/**
 * Basic trigonometry functions
 *
 * Solidity library offering the functionality of basic trigonometry functions
 * with both input and output being integer approximated.
 *
 * This code was originally written by Lefteris Karapetsas
 * https://github.com/Sikorkaio/sikorka/blob/master/contracts/trigonometry.sol
 *
 * I made several changes to make it easy for me to manage and use. 
 *
 * @author Lefteris Karapetsas 
 * @author Satoshi Nakajima (snakajima)
 * @license BSD3
 */

// SPDX-License-Identifier: BSD3
pragma solidity ^0.8.6;

library Trigonometry {

    // constant sine lookup table generated by gen_tables.py
    // We have no other choice but this since constant arrays don't yet exist
    uint8 constant entry_bytes = 2;
    bytes constant sin_table = "\x00\x00\x0c\x8c\x18\xf9\x25\x28\x30\xfb\x3c\x56\x47\x1c\x51\x33\x5a\x82\x62\xf1\x6a\x6d\x70\xe2\x76\x41\x7a\x7c\x7d\x89\x7f\x61\x7f\xff";

    function sin_table_lookup(uint index) pure internal returns (uint16) {
        bytes memory table = sin_table;
        uint offset = (index + 1) * entry_bytes;
        uint16 trigint_value;
        assembly {
            trigint_value := mload(add(table, offset))
        }

        return trigint_value;
    }

    /**
     * Return the sine of an integer approximated angle as a signed 16-bit
     * integer.
     *
     * @param _angle A 14-bit angle. This divides the circle into 16384 (0x4000)
     *               angle units, instead of the standard 360 degrees.
     * @return The sine result as a number in the range -32767 to 32767.
     */
    function sin(uint _angle) internal pure returns (int) {
        uint angle = _angle % 0x4000;
        if (angle < 0x2000) {
            return sinQuarter(angle < 0x1000 ? angle : 0x2000 - angle);
        }
        return -sinQuarter(angle < 0x3000 ? angle - 0x2000 : 0x4000 - angle);
    }

    function sinQuarter(uint _angle) internal pure returns (int) {
        if (_angle == 0x1000) {
            return 0x7fff;
        }
        uint index = _angle / 0x100; // high 4-bit
        uint interp = _angle & 0xFF; // low 8-bit
        uint x1 = sin_table_lookup(index);
        uint x2 = sin_table_lookup(index + 1);
        return int(x1 + ((x2 - x1) * interp) / 0x100);
    }

    /**
     * Return the cos of an integer approximated angle.
     * It functions just like the sin() method but uses the trigonometric
     * identity sin(x + pi/2) = cos(x) to quickly calculate the cos.
     */
    function cos(uint _angle) internal pure returns (int) {
        return sin(_angle + 0x1000);
    }
}