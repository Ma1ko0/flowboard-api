<?php
class ArrayHelper
{

	/**
	 * Searches for an object in an array with an attibute $attributename
	 * equals $attribute
	 *
	 * @param array $array Array to search in
	 * @param string $attributename Name of the attribute
	 * @param object $attribute Attribute value that must be equal
	 * @return object|bool
	 */
	public static function arrayFindObject($array, $attributename, $attribute)
	{
		foreach ($array as $item) {
			try {
				$class = new ReflectionClass(get_class($item));
				$prop = $class->getProperty($attributename);
				if ($prop->getValue($item) === $attribute) {
					return $item;
				}
			} catch (ReflectionException $ex) {
				echo $ex . "\n";
			}
		}
		return false;
	}

	/**
	 * Searches for all objects in an array with an attibute $attributename
	 * equals $attribute
	 *
	 * @param array $array Array to search in
	 * @param string $attributename Name of the attribute
	 * @param object $attribute Attribute value that must be equal
	 * @return array of objects
	 */
	public static function arrayFindallObject(&$array, $attributename, $attribute)
	{
		$result = [];
		foreach ($array as &$item) {
			try {
				$class = new ReflectionClass(get_class($item));
				$prop = $class->getProperty($attributename);
				if ($prop->getValue($item) === $attribute) {
					array_push($result, $item);
				}
			} catch (ReflectionException $ex) {
				echo $ex . "\n";
			}
		}
		return $result;
	}
}
