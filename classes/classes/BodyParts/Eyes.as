package classes.BodyParts {
import classes.internals.EnumValue;

public class Eyes extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "FOUR_SPIDER_EYES")
	 * - name: human-readable default name, ("human", "4 spider")
	 */
	public static var Types:/*EnumValue*/Array = [];
	
	public static const HUMAN:int                = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {name:"human"})
	public static const FOUR_SPIDER_EYES:int     = 1;
	EnumValue.add(Types, FOUR_SPIDER_EYES, "FOUR_SPIDER_EYES", {name:"six spider"})
	public static const BLACK_EYES_SAND_TRAP:int = 2;
	EnumValue.add(Types, BLACK_EYES_SAND_TRAP, "BLACK_EYES_SAND_TRAP", {name:"sandtrap"})
	public static const CAT_SLITS:int            = 3;
	EnumValue.add(Types, CAT_SLITS, "CAT_SLITS", {name:"cat"})
	public static const GORGON:int               = 4;
	EnumValue.add(Types, GORGON, "GORGON", {name:"snake"})
	public static const FENRIR:int               = 5;
	EnumValue.add(Types, FENRIR, "FENRIR", {name:"fenrir"})
	public static const MANTICORE:int            = 6;
	EnumValue.add(Types, MANTICORE, "MANTICORE", {name:"manticore"})
	public static const FOX:int                  = 7;
	EnumValue.add(Types, FOX, "FOX", {name:"fox"})
	public static const REPTILIAN:int            = 8;
	EnumValue.add(Types, REPTILIAN, "REPTILIAN", {name:"reptilian"})
	public static const SNAKE:int                = 9;
	EnumValue.add(Types, SNAKE, "SNAKE", {name:"snake"})
	public static const DRAGON:int               = 10;
	EnumValue.add(Types, DRAGON, "DRAGON", {name:"dragon"})
	public static const DEVIL:int                = 11;
	EnumValue.add(Types, DEVIL, "DEVIL", {name:"devil"})
	public static const ONI:int                  = 12;
	EnumValue.add(Types, ONI, "ONI", {name:"oni"})
	public static const ELF:int                  = 13;
	EnumValue.add(Types, ELF, "ELF", {name:"elf"})
	public static const RAIJU:int                = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, RAIJU, "RAIJU", {name:"raiju"})
	public static const VAMPIRE:int              = 15;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {name:"vampire"})
	public static const GEMSTONES:int            = 16;
	EnumValue.add(Types, GEMSTONES, "GEMSTONES", {name:"gemstone"})
	public static const FERAL:int            	 = 17;
	EnumValue.add(Types, FERAL, "FERAL", {name:"feral"})
	public static const GRYPHON:int            	 = 18;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {name:"gryphon"})
	public static const INFERNAL:int           	 = 19;
	EnumValue.add(Types, INFERNAL, "INFERNAL", {name:"infernal"})
	public static const ORC:int		           	 = 20;
	EnumValue.add(Types, ORC, "ORC", {name:"orc"})
	public static const CAVE_WYRM:int		     = 21;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {name:"cave wyrm"})
	public static const HINEZUMI:int		     = 22;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {name:"hinezumi"})
	public static const BEAR:int			     = 23;
	EnumValue.add(Types, BEAR, "BEAR", {name:"bear"})
	public static const DISPLACER:int			 = 24;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {name:"displacer"})
	public static const FIRE_SNAIL:int			 = 25;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {name:"fire snail"})
	public static const GHOST:int				 = 26;
	EnumValue.add(Types, GHOST, "GHOST", {name:"ghost"})
	public static const JIANGSHI:int			 = 27;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {name:"jiangshi"})
	public static const GOAT:int			     = 28;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, GOAT, "GOAT", {name:"goat"})
	public static const CENTIPEDE:int			 = 29;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {name:"centipede"})
	public static const KRAKEN:int			     = 30;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {name:"kraken"})
	public static const FROSTWYRM:int			 = 31;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {name:"frost wyrm"})
	public static const CANCER:int               = 32;
	EnumValue.add(Types, CANCER, "CANCER", {name:"cancer"})
	public static const FAIRY:int                = 33;
	EnumValue.add(Types, FAIRY, "FAIRY", {name:"fairy"})
	public static const GREMLIN:int              = 34;
	EnumValue.add(Types, GREMLIN, "GREMLIN", {name:"gremlin"})
	public static const WEASEL:int               = 35;
	EnumValue.add(Types, WEASEL, "WEASEL", {name:"weasel"})
	public static const MONOEYE:int              = 36;
	EnumValue.add(Types, MONOEYE, "MONOEYE", {name:"monoeye"})
	public static const RATATOSKR:int            = 37;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {name:"ratatoskr"})
	public static const FIENDISH:int             = 38;
	EnumValue.add(Types, FIENDISH, "FIENDISH", {name:"fiendish"})
	public static const DEAD_EYES:int            = 39;
	EnumValue.add(Types, DEAD_EYES, "DEAD_EYES", {name:"dead"})
	
	public var count:int;
	public var colour:String = "brown";
	public function Eyes() {
		super(null, null);
	}
}
}
