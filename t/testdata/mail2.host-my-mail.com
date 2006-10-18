# dmidecode 2.2
SMBIOS 2.3 present.
44 structures occupying 1337 bytes.
Table at 0x000F0000.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Phoenix Technologies, LTD
		Version: 6.00 PG
		Release Date: 03/22/2005
		Address: 0xE0000
		Runtime Size: 128 kB
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			BIOS ROM is socketed
			EDD is supported
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: VIA Technologies, Inc.
		Product Name: PM800-8237
		Version:  
		Serial Number:  
		UUID: Not Present
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer:  
		Product Name: PM800-8237
		Version:  
		Serial Number:  
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer:  
		Type: Desktop
		Lock: Not Present
		Version:  
		Serial Number:  
		Asset Tag:  
		Boot-up State: Unknown
		Power Supply State: Unknown
		Thermal State: Unknown
		Security Status: Unknown
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: Socket 478
		Type: Central Processor
		Family: Pentium 4
		Manufacturer: Intel
		ID: 29 0F 00 00 FF FB EB BF
		Signature: Type 0, Family F, Model 2, Stepping 9
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			PAE (Physical address extension)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			SS (Self-snoop)
			HTT (Hyper-threading technology)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Intel(R) Pentium(R) 4 CPU
		Voltage: 0.0 V
		External Clock: 133 MHz
		Max Speed: 1500 MHz
		Current Speed: 2800 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x000B
		L2 Cache Handle: 0x000D
		L3 Cache Handle: Not Provided
		Serial Number:  
		Asset Tag:  
		Part Number:  
Handle 0x0005
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: Socket 478
		Type: Central Processor
		Family: Unknown
		Manufacturer: Unknown
		ID: 00 00 00 00 00 00 00 00
		Version: Intel(R) Pentium(R) 4 CPU
		Voltage: 0.0 V
		External Clock: 133 MHz
		Max Speed: 1500 MHz
		Current Speed: 2800 MHz
		Status: Populated, Disabled By User
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x000C
		L2 Cache Handle: 0x000E
		L3 Cache Handle: Not Provided
		Serial Number:  
		Asset Tag:  
		Part Number:  
Handle 0x0006
	DMI type 5, 24 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: Four-way Interleave
		Maximum Memory Module Size: 32 MB
		Maximum Total Memory Size: 128 MB
		Supported Speeds:
			70 ns
			60 ns
		Supported Memory Types:
			Standard
			EDO
		Memory Module Voltage: 5.0 V
		Associated Memory Slots: 4
			0x0007
			0x0008
			0x0009
			0x000A
		Enabled Error Correcting Capabilities: None
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A0
		Bank Connections: None
		Current Speed: 60 ns
		Type: Other
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A1
		Bank Connections: 2 3
		Current Speed: 60 ns
		Type: Other
		Installed Size: 512 MB (Double-bank Connection)
		Enabled Size: 512 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A2
		Bank Connections: None
		Current Speed: 60 ns
		Type: Other
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: A3
		Bank Connections: None
		Current Speed: 60 ns
		Type: Other
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x000B
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 20 KB
		Maximum Size: 20 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000C
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 20 KB
		Maximum Size: 20 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000D
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: External Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000E
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: External Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FDD
		Internal Connector Type: On Board Floppy
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: 8251 FIFO Compatible
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator:  
		External Connector Type: DB-9 male
		Port Type: Serial Port 16450 Compatible
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator:  
		External Connector Type: DB-9 male
		Port Type: Serial Port 16450 Compatible
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: LPT1
		Internal Connector Type: DB-25 female
		External Reference Designator:  
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Keyboard
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB0
		External Connector Type: Other
		Port Type: USB
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: AUDIO
		External Connector Type: None
		Port Type: Audio Port
Handle 0x0019
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI0
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 1
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x001A
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI1
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 2
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x001B
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI2
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 3
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x001C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI3
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 4
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x001D
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI4
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 5
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x001E
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: AGP
		Type: 32-bit AGP
		Current Usage: In Use
		Length: Long
		ID: 8
		Characteristics:
			5.0 V is provided
Handle 0x001F
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 3
			n|US|iso8859-1
			n|US|iso8859-1
			r|CA|iso8859-1
		Currently Installed Language: n|US|iso8859-1
Handle 0x0020
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 2 GB
		Error Information Handle: Not Provided
		Number Of Devices: 4
Handle 0x0021
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0020
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: A0
		Bank Locator: Bank0/1
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0022
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0020
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: 512 MB
		Form Factor: DIMM
		Set: None
		Locator: A1
		Bank Locator: Bank2/3
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0023
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0020
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: A2
		Bank Locator: Bank4/5
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0024
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0020
		Error Information Handle: Not Provided
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: None
		Locator: A3
		Bank Locator: Bank6/7
		Type: Unknown
		Type Detail: None
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0025
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0020
		Partition Width: 0
Handle 0x0026
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x0021
		Memory Array Mapped Address Handle: 0x0025
		Partition Row Position: 1
Handle 0x0027
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Device Handle: 0x0022
		Memory Array Mapped Address Handle: 0x0025
		Partition Row Position: 1
Handle 0x0028
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x0023
		Memory Array Mapped Address Handle: 0x0025
		Partition Row Position: 1
Handle 0x0029
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000000003FF
		Range Size: 1 kB
		Physical Device Handle: 0x0024
		Memory Array Mapped Address Handle: 0x0025
		Partition Row Position: 1
Handle 0x002A
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x002B
	DMI type 127, 4 bytes.
	End Of Table