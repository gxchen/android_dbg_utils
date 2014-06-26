
import xml.dom.minidom

def load_xml_file(file):
	dom = xml.dom.minidom.parse(file)
	return dom

def main():
	xml_file = '.repo/manifest.xml'
	#dst_project_name = 'platform/hardware/qcom/camera'
	dst_project_name = 'platform/abi/cpp'

	xml_root = load_xml_file(xml_file).documentElement

	project_list = xml_root.getElementsByTagName('project')

	for node in project_list:
		name = node.getAttribute('name')
		if (name == dst_project_name):
			print "name: ", node.getAttribute('name')
			print "revision: ", node.getAttribute('revision')
			break


if __name__ == '__main__':
	main()